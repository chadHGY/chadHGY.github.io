.PHONY: run_server
run_server: ## start jekyll server locally
	@bundle config set --local path ~/.bundle
	@bundle exec jekyll serve --trace
	# @bundle exec jekyll serve --incremental

.PHONY: run_publish
run_publish: ## start jekyll server locally
	@./run_publish_github.sh