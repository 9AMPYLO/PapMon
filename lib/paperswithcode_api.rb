# frozen_string_literal: true

require 'http'
require_relative 'paper'
require_relative 'dataset'
require_relative 'repository'
require_relative 'response'
require_relative 'request'

# PaperWithCode API module
module PapMon
  # PaperWithCode API
  class PaperswithcodeApi
    API_PROJECT_ROOT = 'https://paperswithcode.com/api/v1/'

    def paper(papername)
      paper_response = Request.new(API_PROJECT_ROOT).paper(papername).parse
      Paper.new(paper_response, self)
    end

    def datasets(paper_id)
      dataset_data = Request.new(API_PROJECT_ROOT).datasets(paper_id).parse
      dataset_data['results'].map { |dataset| Dataset.new(dataset) }
    end

    def repositories(paper_id)
      repo_data = Request.new(API_PROJECT_ROOT).repositories(paper_id).parse
      repo_data['results'].map { |repo| Repository.new(repo) }
    end
  end
end
