SHELL     := bash
MAKEFLAGS += --warn-undefined-variables
.SILENT:

Top=$(shell git rev-parse --show-toplevel)
Data ?= $(Top)/data/optimize
Tmp  ?= $(HOME)/tmp

Out=$(HOME)/tmp
Act ?= _mqs
acts: ## experiment: dumb vs smart
	mkdir -p ~/tmp
	$(MAKE) acthw3 > $(Tmp)/$(Act).sh
	bash $(Tmp)/$(Act).sh

acthw3: ## create script: dumb vs smart
	echo "mkdir -p $(Out)/$(Act)"
	echo "rm -r $(Out)/$(Act)/*"
	$(foreach d, config hpo misc process,         \
		$(foreach f, $(wildcard $(Data)/$d/*.csv),   \
				echo "python3.13 $(PWD)/experiment.py $f | tee $(Out)/$(Act)/$(shell basename $f) & "; ))
	echo "wait"