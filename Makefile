rubocop:
	@bundle exec rubocop

rubocop-fix:
	@bundle exec rubocop -a

rbp:
	@bundle exec rails_best_practices . -c config/rails_best_practices.yml

traceroute:
	@./bin/rake traceroute

bundler-audit:
	@bundle exec bundler-audit update
	@bundle exec bundler-audit

brakeman:
	@bundle exec brakeman -o /tmp/brakeman-report.html

init-provisioner:
	@./expd-bin/generate-tfvars
	@./expd-bin/generate-awscredentials
	@./expd-bin/terraform-docker init

provisioning:
	@./expd-bin/terraform-docker apply

provisioning-plan:
	@./expd-bin/terraform-docker plan

provisioning-destroy:
	@./expd-bin/terraform-docker destroy
