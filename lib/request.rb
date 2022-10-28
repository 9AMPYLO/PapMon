# frozen_string_literal: true

# PaperWithCode API module
module PapMon
  # request class
  class Request
    def get(url)
      http_response = HTTP.headers('Accept' => 'application/json').get(url)
      Response.new(http_response).tap do |response|
        raise response.error unless response.successful?
      end
    end
  end
end
