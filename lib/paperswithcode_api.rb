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
  class PapersWithCodeApi
    API_PROJECT_ROOT = 'https://paperswithcode.com/api/v1/'

    def paper(papername)
      # paper_response = Request.new(API_PROJECT_ROOT).paper(papername).parse
      paper_url = API_PROJECT_ROOT + ['papers', papername, ''].join('/')
      paper_response = Request.new.get(paper_url).parse
      Paper.new(paper_response, self)
    end

    def datasets(paper_id)
      # dataset_data = Request.new(API_PROJECT_ROOT).datasets(paper_id).parse
      dataset_url = API_PROJECT_ROOT + ['papers', paper_id, 'datasets', ''].join('/')
      dataset_data = Request.new.get(dataset_url).parse
      dataset_data['results'].map { |dataset| Dataset.new(dataset) }
    end

    def repositories(paper_id)
      # repo_data = Request.new(API_PROJECT_ROOT).repositories(paper_id).parse
      repo_url = API_PROJECT_ROOT + ['papers', paper_id, 'repositories', ''].join('/')
      repo_data = Request.new.get(repo_url).parse
      repo_data['results'].map { |repo| Repository.new(repo) }
    end
  end
end
