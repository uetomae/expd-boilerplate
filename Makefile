init-provisioner:
	@./expd-bin/generate-tfvars
	@./expd-bin/generate-awscredentials
	@./expd-bin/terraform-docker init

provisioning-plan:
	@./expd-bin/terraform-docker plan

provisioning:
	@./expd-bin/terraform-docker apply
