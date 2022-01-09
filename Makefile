all: init elastic

init:
	@echo "Installing dependencies..."
	@bash -c "scripts/dependencies.sh"
	@echo "Building cluster k3d..."
	@k3d cluster create in-house-lab --config clusters/3m-5w.yaml

stop:
	@echo "Stopping cluster k3d..."
	@k3d cluster stop in-house-lab

destroy:
	@echo "Deleting cluster k3d..."
	@k3d cluster delete in-house-lab

elastic:
	@bash -c "scripts/elastic.sh"