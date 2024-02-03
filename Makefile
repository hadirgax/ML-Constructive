
CONDA_ENV_NAME ?= mlconstructive

export PYTHONPATH := $(PWD):$(PWD)/version1:$(PYTHONPATH)

#===== Environment =====

env-create:
	conda env create -n $(CONDA_ENV_NAME) -f environment_dev.yml

env-remove:
	conda env remove -n $(CONDA_ENV_NAME)

env-update: env-remove env-create


#===== Dependencies =====

install-deps:
	sudo apt-get update
	sudo apt-get install libgl1-mesa-glx

install-pyconcord:
	pip install 'pyconcorde @ git+https://github.com/jvkersch/pyconcorde'


#===== CLI ML-Constructive =====

cli-help:
	echo $(PYTHONPATH)
	cd version1 && \
	python cli.py --help

run-create-instances:
	cd version1 && \
	python cli.py --operation create_instances

run-statistical-study:
	cd version1 && \
	python cli.py --operation statistical_study

run-train:
	cd version1 && \
	python cli.py --operation train

run-solve-tsplib:
	cd version1 && \
	python cli.py --operation solve_TSPLIB
