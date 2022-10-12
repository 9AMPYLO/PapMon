# frozen_string_literal: true

require 'http'
require_relative 'paper'
require_relative 'dataset'
require_relative 'repository'

# PaperWithCode API module
module PapMon
  # PaperWithCode API
  class PaperswithcodeApi
    API_PROJECT_ROOT = 'https://paperswithcode.com/api/v1/'
    module Errors
      class NotFound < StandardError; end
    end
    HTTP_ERROR = {
      404 => Errors::NotFound
    }.freeze

    def paper(papername)
      paper_req_url = pwc_api_path(['papers', papername, ''].join('/'))
      # Json.parse
      paper_data = call_pwc_api(paper_req_url).parse
      Paper.new(paper_data, self)
    end

    def datasets(paper_id)
      # dataset_req_url = "#{API_PROJECT_ROOT}/papers/#{paper_id}/datasets/"
      dataset_req_url = pwc_api_path(['papers', paper_id, 'datasets', ''].join('/'))
      dataset_data = call_pwc_api(dataset_req_url).parse
      dataset_data['results'].map { |dataset| Dataset.new(dataset) }
    end

    def repositories(paper_id)
      # repo_req_url = "#{API_PROJECT_ROOT}/papers/#{paper_id}/repositories/"
      repo_req_url = pwc_api_path(['papers', paper_id, 'repositories', ''].join('/'))
      repo_data = call_pwc_api(repo_req_url).parse
      repo_data['results'].map { |repo| Repository.new(repo) }
    end

    private

    def pwc_api_path(path)
      "#{API_PROJECT_ROOT}#{path}"
    end

    def call_pwc_api(url)
      result = HTTP.headers('Accept' => 'application/json').get(url)
      raise HTTP_ERROR[result.code] if HTTP_ERROR.include?(result.code)

      result
    end
  end
end
