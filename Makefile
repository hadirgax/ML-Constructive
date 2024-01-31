
CONDA_ENV_NAME ?= mlconstructive

#===== Environment =====

env-create:
	conda env create -n $(CONDA_ENV_NAME) -f environment_dev.yml

env-remove:
	conda env remove -n $(CONDA_ENV_NAME)

env-update: env-remove env-create


install-deps:
	sudo apt-get update
	sudo apt-get install libgl1-mesa-glx
