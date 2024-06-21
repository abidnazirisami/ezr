#!/usr/bin/env lua
-- <!-- vim : set ts=4 sts=4 et : -->
--
--                       ___           
--                      /\_ \           
--       _ __   __  __  \//\ \     _ __  
--      /\`'__\/\ \/\ \   \ \ \   /\`'__\ 
--      \ \ \/ \ \ \_\ \   \_\ \_ \ \ \/ 
--       \ \_\  \ \____/   /\____\ \ \_\ 
--        \/_/   \/___/    \/____/  \/_/ 
--     
-- rulr.lua multi-objective rule generation   
-- (c) 2024 Tim Menzies <timm@ieee.org>, BSD-2 license.

local the = { bins  = 7,
              fmt   = "%6.3f", 
              train = "../data/misc/auto93.csv"}

-----------------------------------------------------------------------------------------
--       |  o  |_  
--       |  |  |_) 

local abs,log,max,min = math.abs, math.log, math.max, math.min
local as,cdf,cells,copy,csv,o,okeys,olist,oo,push,sort,sortDown,welford

-- lists
function push(t,x)   t[1+#t] = x; return x end
function copy(t) 
  if type(t) ~= "table" then return t end 
  u={}; for k,v in pairs(t) do u[copy(k)] = copy(v) end
  return setmetatable(u, getmetatable(t)) end

-- sorting
function sort(t,fun) table.sort(t,fun); return t end

function sortDown(k) return function(a,b) return a[k] > b[k] end end

-- maths
function cdf(z) return 1 - 0.5*math.exp(1)^(-0.717*z - 0.416*z*z) end

function welford(x,n,mu,m2,    d,sd)
  d  = x - mu
  mu = mu + d/n
  m2 = m2 + d*(x - mu)
  sd = n<2 and 0 or (m2/(n - 1))^.5  
  return mu,m2,sd end

-- things to strings
fmt = string.format

function oo(x) print(o(x)); return x end

function o(t)
  if type(t)=="number" then return t == math.floor(t) and tostring(t) or fmt(the.fmt,t) end
  if type(t)~="table"  then return tostring(t) end
  return "(" .. table.concat(#t==0 and sort(okeys(t)) or olist(t)," ")  .. ")" end

function olist(t,u) u={}; for k,v in pairs(t) do push(u,o(v))                 end; return u end
function okeys(t,u) u={}; for k,v in pairs(t) do push(u,fmt(":%s %s",k,o(v))) end; return u end

-- strings to things
function coerce(s,    f)
  f=function(s) 
    if s=="nil" then return nil else return s=="true" or s ~="false" and s or false end end
  return math.tointeger(s) or tonumber(s) or f(s:match'^%s*(.*%S)') end

function cells(s,    t)
  t={}; for s1 in s:gsub("%s+", ""):gmatch("([^,]+)") do t[1+#t]=coerce(s1) end; return t end

function csv(src)
  src = src=="-" and io.stdin or io.input(src)
  return function(      s)
    s = io.read()
    if s then return cells(s) else io.close(src) end end end
-----------------------------------------------------------------------------------------
--        _  ._   _    _.  _|_   _  
--       (_  |   (/_  (_|   |_  (/_ 

local NUM,SYM,DATA,COLS = {},{},{},{}

local function new (kl,o) kl.__index=kl; setmetatable(o, kl); return o end

function SYM.new(name,pos) return new(SYM, {name=name, pos=pos, n=0, seen={}, bins={}}) end

function NUM.new(name,pos)
  return new(NUM, {name=name, pos=pos, n=0, mu=0, m2=0, sd=0, lo=1E30, hi=-1E30, bins={},
                   goal = (name or ""):find"-$" and 0 or 1}) end

function COLS.new(names,    all,x,y,col) 
  all,x,y = {},{},{}
  for i,s in pairs(names) do 
    col = push(all, (s:find"^[A-Z]" and NUM or SYM).new(s,i))
    if not s:find"X$" then push(s:find"[!+-]$" and y or x,col) end end
  return new(COLS, {names=names, all=all, x=x, y=y}) end

function DATA.new(  names) 
  return  new(DATA, {rows={}, cols=names and COLS.new(names) or nil}) end
-----------------------------------------------------------------------------------------
--       ._   _    _.   _| 
--       |   (/_  (_|  (_| 

function DATA:read(file) for   row in csv(file) do self:add(row) end; return self end
function DATA:load(t)    for _,row in pairs(t)  do self:add(row) end; return self end
-----------------------------------------------------------------------------------------
--            ._    _|   _.  _|_   _  
--       |_|  |_)  (_|  (_|   |_  (/_ 
--            |                       

function DATA:add(t) 
  if self.cols then push(self.rows, self.cols:add(t)) else 
     self.cols = COLS.new(t) end end

function COLS:add(t)
  for _,cs in pairs{self.x,self.y} do for _,c in pairs(cs) do c:add(t[c.pos]) end end 
  return t end

function SYM:add(x)
  if x ~= "?" then
    self.n  = self.n+1
    self.seen[x] = 1 + (self.seen[x] or 0) end end 

function NUM:add(x,    d)
  if x ~= "?" then
    self.n  = self.n + 1
    self.mu, self.m2, self.sd = welford(x, self.n, self.mu, self.m2)
    if x > self.hi then self.hi=x end
    if x < self.lo then self.lo=x end end end
-----------------------------------------------------------------------------------------
--        _.        _   ._     
--       (_|  |_|  (/_  |   \/ 
--         |                /  

function NUM:norm(x) return x=="?" and x or (x - self.lo)/(self.hi - self.lo) end

function DATA:chebyshev(row,cols,     d)
  d=0; for _,c in pairs(cols) do d = max(d,abs(c:norm(row[c.pos]) - c.goal)) end
  return d end

function DATA:sort(      d)
  d = function(row) return self:chebyshev(row, self.cols.y) end
  table.sort(self.rows, function(a,b) return  d(a) < d(b) end) 
  return self end
-----------------------------------------------------------------------------------------
--       ._       |   _  
--       |   |_|  |  (/_  

function SYM:bin(x) return x end

function NUM:bin(x,    z,area) 
  if x=="?" then return x end
  z    = (x - self.mu) / self.sd
  area = z >= 0 and cdf(z) or 1 - cdf(-z) 
  return max(1, min(the.bins, 1 + (area * the.bins // 1))) end 

function DATA:bins(     bins,tmp,d)
  bins,tmp = {},{}
  for _,row in pairs(self.rows) do
    d = self:chebyshev(row, self.cols.y)
    for _,col in pairs(self.cols.x) do
      col.bins[b]   = col.bins[b] or push(bins, {col=col,bin=b,n=0}) 
      col.bins[b].n = cols.bins[b].n + (1 - d)/#self.rows end end 
  return bins

function DATA:growRule(  rows,     _add2rule,_score)
  function _add2rule(bin,rule,    pos) 
    pos = bin.col.pos
    rule[pos] = rule[pos] or {}
    push(rule[pos], bin) end

  function _score(rule,    n,s) 
    n,s = 0,0
    for _,row in pairs(rows or self.rows) do 
      if self:selects(rule, row) then
        n = n + 1 
        s = s + 1 - self:chebyshev(row, self.cols.y) end end 
    return s/n  end

  local now,b4,last = {},{},0
  for _,bin in pairs(sort(bins, sortDown"n")) do
    _add2rule(bin,now)
    local tmp = _score(now)
    if tmp > last then _add2rule(b4,bin) else return b4 end 
    last = tmp end end 

function DATA:selects(rule,row,     _selects1,col,x) -- returns true if each bin is satisfied
  function _selects1(bins, want) -- returns true if any bin is satisfied
    for _,bin in pairs(bins) do if bin.bin==want then return true end end  end

  for pos,bins in pairs(rule) do
    col = self.cols.all[pos]
    x = row[pos] 
    if x ~= "?" then
      if not _selects1(bins, col:bin(x)) then return false end end end
  return true end

-----------------------------------------------------------------------------------------
--       ._ _    _.  o  ._  
--       | | |  (_|  |  | | 

local main={}
function main.ver() print("sandbox v0.1") end

function main.the() oo(the) end

function main.csv(    n) 
  n=0; for row in csv(the.train) do n=n+1; if n % 50==0 then print(n,o(row)) end end end

function main.cols(     d) 
  d = DATA.new():read(the.train)
  for _,col in pairs(d.cols.y) do oo(col) end end

function main.data(     d,want) 
  d = DATA.new():read(the.train):sort()
  m = 1
  for n,row in pairs(d.rows) do 
    if n==m then m=m*2; print(n,o(d:chebyshev(row,d.cols.y)),o(row)) end end end

function main.bins()
  d = DATA.new():read(the.train):sort()
  for _,bin in pairs(d:bins()) do  print(o(bin.n), bin.bin, bin.col.name) end end

if    pcall(debug.getlocal, 4, 1)
then  return {DATA=DATA,NUM=NUM,SYM=SYM} 
else  main[ arg[1] or "ver" ]()  end
