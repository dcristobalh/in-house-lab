all: init
	@bash -c "scripts/elastic/elastic.sh"
	@bash -c "scripts/tekton/tekton.sh"
	@bash -c "scripts/cert-manager/cert-manager.sh"
	@bash -c "scripts/dashboard/dashboard.sh"
	@bash -c "scripts/everything.sh"

init-cert: init
	@bash -c "scripts/cert-manager/cert-manager.sh"
	
init:
	@echo "Installing dependencies..."
	@bash -c "scripts/dependencies.sh"
	@echo "Building cluster..."
	@k3d cluster create in-house-lab --config clusters/3m-5w.yaml

stop:
	@echo "Stopping cluster k3d..."
	@k3d cluster stop in-house-lab

destroy:
	@echo "Deleting cluster k3d..."
	@k3d cluster delete in-house-lab

elastic:
	@bash -c "scripts/elastic/elastic.sh"
	@bash -c "scripts/elastic/info.sh"

tekton:
	@bash -c "scripts/tekton/tekton.sh"
	@bash -c "scripts/tekton/info.sh"

cert-manager:
	@bash -c "scripts/cert-manager/cert-manager.sh"

dashboard:
	@bash -c "scripts/dashboard/dashboard.sh"
	@bash -c "scripts/dashboard/info.sh"