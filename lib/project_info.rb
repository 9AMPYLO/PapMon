# frozen_string_literal: true

require 'http'
require 'yaml'

def pwc_api_path(path)
  "https://paperswithcode.com/api/v1/#{path}"
end

def call_pwc_api(url)
  HTTP.get(url)
end

# HAPPY paper request
pwc_response = {}
pwc_results = {}
paper_url = pwc_api_path('papers/be-your-own-teacher-improve-the-performance/')
pwc_response[paper_url] = call_pwc_api(paper_url)
paper = pwc_response[paper_url].parse

# Get the paper API
pwc_results['id'] = paper['id']
pwc_results['arxiv_id'] = paper['arxiv_id']
pwc_results['url_abs'] = paper['url_abs']
pwc_results['title'] = paper['title']
pwc_results['authors'] = paper['authors']
pwc_results['published'] = paper['published']
pwc_results['proceeding'] = paper['proceeding']

# Get the datasets API
dataset_url = pwc_api_path("papers/#{pwc_results['id']}/datasets/")
pwc_response[dataset_url] = call_pwc_api(dataset_url)
datasets = pwc_response[dataset_url].parse
pwc_results['datasets'] = datasets['results']

# Get the repositories API
repo_url = pwc_api_path("papers/#{pwc_results['id']}/repositories/")
pwc_response[repo_url] = call_pwc_api(repo_url)
repos = pwc_response[repo_url].parse
pwc_results['repositories'] = repos['results']

# BAD paper request
bad_paper_url = pwc_api_path('papers/be-your-own-teacher/')
pwc_response[bad_paper_url] = call_pwc_api(bad_paper_url)
pwc_response[bad_paper_url].parse

File.write('spec/fixtures/results.yml', pwc_results.to_yaml)
