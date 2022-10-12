# frozen_string_literal: true

require_relative 'repository'
require_relative 'dataset'

# PaperWithCode API module
module PapMon
  # Paper Class
  class Paper
    def initialize(paper_data, data_source)
      @paper_data = paper_data
      @data_source = data_source
    end

    def id
      @paper_data['id']
    end

    def arxiv_id
      @paper_data['arxiv_id']
    end

    def url_abs
      @paper_data['url_abs']
    end

    def title
      @paper_data['title']
    end

    def authors
      @paper_data['authors']
    end

    def published
      @paper_data['published']
    end

    def proceeding
      @paper_data['proceeding']
    end

    def repositories
      @repositories ||= @data_source.repositories(id)
    end

    def datasets
      @datasets ||= @data_source.datasets(id)
    end
  end
end
