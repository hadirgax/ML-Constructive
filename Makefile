
CONDA_ENV_NAME ?= mlconstructive

export PYTHONPATH := $(PWD):$(PWD)/version1:$(PYTHONPATH)

#===== Environment =====

env-create:
	conda env create -n $(CONDA_ENV_NAME) -f environment_dev.yml

env-remove:
	conda env remove -n $(CONDA_ENV_NAME)

env-update: env-remove env-create


install-deps:
	sudo apt-get update
	sudo apt-get install libgl1-mesa-glx


create_instances:
	echo $(PYTHONPATH)
	python version1/cli.py --operation create_instances
