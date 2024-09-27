## Run Experiment
Run the experiment with the following command:

```Shell
bash run_exp.sh
```

## Claims

**JJR1**: Nothing works better than 50 random guesses for low dimensional problems (less than 6 x attributes).
**JJR2**: But such random guessing is rubbish for higher dimensional data.

## Results
Here are the results:

```Shell
All results-----------------
RANK                0            1            2            3               4             5            6            7            8            9
exploit/b=True     90            8            2                                                                                               
explore/b=True     84           12            4                                                                                               
exploit/b=False    73           20            4            2                                                                                  
explore/b=False    63           20            8            4               4                                                                  
dumb               49           33           18                                                                                               
rrp                14           14           12           29              14            14            2                                       
asIs                2            8            8           20              14            14           12           14            4            2
                                                                                                                 100                          
#                                                                                                                                          
#EVALS                                                                                                                                     
RANK                      0            1            2            3               4             5            6            7            8            9
exploit/b=True     29 (  8)     33 (  0)     20 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
explore/b=True     30 ( 12)     30 (  0)     20 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
exploit/b=False    26 (  4)     30 (  8)     35 (  0)     20 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
explore/b=False    28 (  8)     39 ( 12)     35 (  0)     30 (  0)        40 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
dumb               26 (  4)     36 (  4)     29 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
rrp                 4 (  0)      4 (  0)      4 (  0)      5 (  0)         5 (  0)       4 (  0)      4 (  0)      0 (  0)      0 (  0)      0 (  0)
asIs              3840 (  0)   4369 (  0)   4588 (  0)   13607 (20885)   15849 (  0)   3530 (  0)   8782 (  0)   2709 (  0)   5378 (  0)   1080 (  0)
                    0 (  0)      0 (  0)      0 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
#                                                                                                                                          
#DELTAS                                                                                                                                    
RANK                      0            1            2            3               4             5            6            7            8            9
exploit/b=True     74 ( 22)     59 (  0)     16 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
explore/b=True     74 ( 22)     50 (  0)     48 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
exploit/b=False    75 ( 26)     57 ( 19)     28 (  0)     72 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
explore/b=False    71 ( 26)     55 ( 18)     39 (  0)     64 (  0)        45 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
dumb               69 ( 23)     61 ( 10)     59 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)      0 (  0)      0 (  0)      0 (  0)
rrp                69 (  0)     46 (  0)     34 (  0)     32 ( 14)        31 (  0)      23 (  0)     39 (  0)      0 (  0)      0 (  0)      0 (  0)
                    0 (  0)      0 (  0)      0 (  0)      0 (  0)         0 (  0)       0 (  0)      0 (  0)     96 (  0)      0 (  0)      0 (  0)
Low dimensionality results-----------------
RANK                0           1             2             3           4           5           6           7           8           9
exploit/b=True     93                         7                                                                                      
exploit/b=False    73          20             7                                                                                      
explore/b=True     67          20            13                                                                                      
explore/b=False    53          13            20             7           7                                                            
dumb               53          27            20                                                                                      
rrp                27          13             7            13          13          27                                                
asIs                            7             7            27          20                       7          20           7           7
                                                                                                          100                        
#                                                                                                                                 
#EVALS                                                                                                                            
RANK                      0           1             2             3           4           5           6           7           8           9
exploit/b=True     29 (  4)     0 (  0)      20 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
exploit/b=False    24 (  0)    33 (  0)      50 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
explore/b=True     30 ( 12)    33 (  0)      20 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
explore/b=False    29 (  0)    25 (  0)      40 (  0)      30 (  0)    50 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
dumb               26 (  0)    40 (  0)      23 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
rrp                 4 (  0)     4 (  0)       4 (  0)       4 (  0)     4 (  0)     4 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
asIs                0 (  0)   10000 (  0)   10000 (  0)   525 (  0)   284 (  0)     0 (  0)   196 (  0)   582 (  0)   756 (  0)   1080 (  0)
                    0 (  0)     0 (  0)       0 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
#                                                                                                                                 
#DELTAS                                                                                                                           
RANK                      0           1             2             3           4           5           6           7           8           9
exploit/b=True     78 ( 26)     0 (  0)      16 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
exploit/b=False    77 ( 26)    66 (  0)      30 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
explore/b=True     78 ( 26)    58 (  0)      48 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
explore/b=False    84 (  0)    37 (  0)      44 (  0)      69 (  0)    31 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
dumb               71 (  0)    47 (  0)      77 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
rrp                97 (  0)    35 (  0)      33 (  0)      15 (  0)    34 (  0)    25 (  0)     0 (  0)     0 (  0)     0 (  0)     0 (  0)
                    0 (  0)     0 (  0)       0 (  0)       0 (  0)     0 (  0)     0 (  0)     0 (  0)    93 ( 39)     0 (  0)     0 (  0)
High dimensionality results-----------------
RANK                0            1            2            3             4             5            6             7            8
explore/b=True     91            9                                                                                              
exploit/b=True     88           12                                                                                              
exploit/b=False    74           21            3            3                                                                    
explore/b=False    68           24            3            3             3                                                      
dumb               47           35           18                                                                                 
rrp                 9           15           15           35            15             9            3                           
asIs                3            9            9           18            12            21           15            12            3
                                                                                                                100             
#                                                                                                                            
#EVALS                                                                                                                       
RANK                      0            1            2            3             4             5            6             7            8
explore/b=True     30 ( 12)     27 (  0)      0 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
exploit/b=True     29 (  8)     33 (  0)      0 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
exploit/b=False    27 (  4)     29 (  0)     20 (  0)     20 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
explore/b=False    27 (  4)     43 (  0)     20 (  0)     30 (  0)      30 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
dumb               26 (  0)     34 (  8)     32 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
rrp                 4 (  0)      4 (  0)      4 (  0)      5 (  0)       6 (  0)       4 (  0)      4 (  0)       0 (  0)      0 (  0)
asIs              3840 (  0)   2491 (  0)   2784 (  0)   22328 (  0)   27523 (  0)   3530 (  0)   10499 (  0)   4305 (  0)   10000 (  0)
                    0 (  0)      0 (  0)      0 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
#                                                                                                                            
#DELTAS                                                                                                                      
RANK                      0            1            2            3             4             5            6             7            8
explore/b=True     73 ( 22)     42 (  0)      0 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
exploit/b=True     73 ( 22)     59 (  0)      0 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
exploit/b=False    74 ( 20)     54 (  0)     27 (  0)     72 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
explore/b=False    67 ( 20)     60 (  0)     24 (  0)     60 (  0)      59 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
dumb               67 ( 28)     65 ( 16)     51 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)       0 (  0)      0 (  0)
rrp                32 (  0)     51 (  0)     34 (  0)     34 ( 16)      30 (  0)      22 (  0)     39 (  0)       0 (  0)      0 (  0)
                    0 (  0)      0 (  0)      0 (  0)      0 (  0)       0 (  0)       0 (  0)      0 (  0)      94 (  0)      0 (  0)
```

## Observations

1. "Dumb" works slightly better in data with low dimensionality than in higher dimensional ones
2. But it does not work better than all of the "Smart" methods for data with low dimensonality.
3. It is not entirely rubbish for higher dimensional data, at least compared to the low dimensional results. In both cases, "dumb" is at least top 3 out of 7 100% of the time. So, it is not a bad technique considering the simplicity for any data.

## Conclusion

From my observations, I doubt the JJR1/JJR2 hypothesis