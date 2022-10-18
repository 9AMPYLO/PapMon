# frozen_string_literal: true

# PaperWithCode API module
module PapMon
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
