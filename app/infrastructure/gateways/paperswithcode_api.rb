# frozen_string_literal: true

require 'http'

# PaperWithCode API module
module PapMon
  # PaperWithCode API
  class PapersWithCodeApi
    API_PROJECT_ROOT = 'https://paperswithcode.com/api/v1/'

    def paper_data(papername)
      Request.new.paper(papername).parse
    end

    def datasets_data(paper_id)
      Request.new.datasets(paper_id).parse
    end

    def repositories_data(paper_id)
      Request.new.repositories(paper_id).parse
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
        get(paper_url)
      end

      def datasets(paper_id)
        datasets_url = API_PROJECT_ROOT + ['papers', paper_id, 'datasets', ''].join('/')
        get(datasets_url)
      end

      def repositories(paper_id)
        repo_url = API_PROJECT_ROOT + ['papers', paper_id, 'repositories', ''].join('/')
        get(repo_url)
      end
    end

    # Decorates HTTP responses from the API
    class Response < SimpleDelegator
      NotFound = Class.new(StandardError)
      HTTP_ERROR = {
        404 => NotFound
      }.freeze

      def initialize(http_response)
        super(http_response)
        @http_response = http_response
      end

      def successful?
        HTTP_ERROR.keys.include?(@http_response.code)
      end

      def error
        HTTP_ERROR[@http_response.code]
      end
    end
  end
end
