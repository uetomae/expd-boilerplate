init-provisioner:
	./expd-bin/generate-tfvars
	./expd-bin/generate-awscredentials
	./expd-bin/terraform-docker init
