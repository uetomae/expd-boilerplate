metrics: rubocop rbp traceroute bundler-audit brakeman

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

prov-init:
	@./expd-bin/generate-tfvars
	@./expd-bin/generate-awscredentials
	@./expd-bin/terraform-docker init

prov:
	@./expd-bin/terraform-docker apply
	@./expd-bin/generate-deploy-env

prov-plan:
	@./expd-bin/terraform-docker plan

prov-destroy:
	@./expd-bin/terraform-docker destroy
