# frozen_string_literal: true

require 'http'
require 'yaml'
require 'active_support/all'

def pwc_api_path(path)
  "https://paperswithcode.com/api/v1/#{path}"
end

def arxiv_api_path(path)
  "http://export.arxiv.org/api/query?search_query=#{path}"
end

def call_pwc_api(url)
  HTTP.get(url)
end

def call_arxiv_api(url)
  HTTP.get(url)
end

def parse_arxiv_xml(xml)
  arxiv_result = []
  xml_hash = Hash.from_xml(xml)
  paper_element = xml_hash['feed']['entry']
  arxiv_paper = {}
  arxiv_paper['arxiv_id'] = paper_element['id'][21..30]
  arxiv_paper['primary_category'] = paper_element['primary_category']['term']
  arxiv_result.append(arxiv_paper)
  arxiv_result
end

# Get latest 1 paper from arxiv
arxiv_url = arxiv_api_path('cat:cs.CV+OR+cat:cs.AI+OR+cat:cs.LG+OR+cat:cs.CL+OR+cat:cs.NE+OR+cat:stat.ML+&sortBy=lastUpdatedDate&sortOrder=descending&max_results=1')
arxiv_response = call_arxiv_api(arxiv_url)
arxiv_info = parse_arxiv_xml(arxiv_response)
arxiv_id = arxiv_info[0]['arxiv_id']
File.write('spec/fixtures/arxiv.yml', arxiv_info[0].to_yaml)

# Paper request
pwc_response = {}
pwc_results = {}
paper_url = pwc_api_path("papers/?arxiv_id=#{arxiv_id}")
pwc_response[paper_url] = call_pwc_api(paper_url)
paper = pwc_response[paper_url].parse
paper = paper['results'][0]

# Get the paper API
pwc_results['id'] = paper['id']
pwc_results['arxiv_id'] = paper['arxiv_id']
pwc_results['url_abs'] = paper['url_abs']
pwc_results['title'] = paper['title']
pwc_results['published'] = paper['published']
pwc_results['proceeding'] = paper['proceeding']
pwc_results['primary_category'] = arxiv_info[0]['primary_category']

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

puts "Get the latest paper: #{pwc_results['title']}"

File.write('spec/fixtures/paperswithcode.yml', pwc_results.to_yaml)
