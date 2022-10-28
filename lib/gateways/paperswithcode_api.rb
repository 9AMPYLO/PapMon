# frozen_string_literal: true

require 'http'
require_relative 'paper'
require_relative 'dataset'
require_relative 'repository'

# PaperWithCode API module
module PapMon
  # PaperWithCode API
  class PapersWithCodeApi
    API_PROJECT_ROOT = 'https://paperswithcode.com/api/v1/'

    def paper_data(papername)
      paper_data = Request.new.paper(papername).parse
      # Paper.new(paper_response, self)
    end

    def datasets_data(paper_id)
      datasets_data = Request.new.datasets(paper_id).parse
    end

    def repositories(paper_id)
      repositories_data = Request.new.repositories(paper_id).parse
    end

    # request class
    class Request
      def get(url)
        http_response = HTTP.headers('Accept' => 'application/json').get(url)
        Response.new(http_response).tap do |response|
          raise response.error unless response.successful?
        end
      end

      def paper(papername)
        paper_url = API_PROJECT_ROOT + ['papers', papername, ''].join('/')
        paper_response = get(paper_url)
      end

      def datasets(paper_id)
        datasets_url = API_PROJECT_ROOT + ['papers', paper_id, 'datasets', ''].join('/')
        datasets_data = get(dataset_url)
      end

      def repositories(paper_id)
        repo_url = API_PROJECT_ROOT + ['papers', paper_id, 'repositories', ''].join('/')
        repo_data = get(repo_url)
      end
    end

    # response class
    class Response < SimpleDelegator
      module Errors
        class NotFound < StandardError; end
      end
      HTTP_ERROR = {
        404 => Errors::NotFound
      }.freeze
      def initialize(http_response)
        super(http_response)
        @http_response = http_response
      end

      def successful?
        HTTP_ERROR.keys.include?(@http_response.code) ? false : true
      end

      def error
        HTTP_ERROR[@http_response.code]
      end
    end
  end
end
