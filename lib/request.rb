# frozen_string_literal: true

# PaperWithCode API module
module PapMon
  # request class
  class Request
    def initialize(api_project_root)
      @api_project_root = api_project_root
    end

    def paper(papername)
      get(@api_project_root + ['papers', papername, ''].join('/'))
    end

    def datasets(paper_id)
      get(@api_project_root + ['papers', paper_id, 'datasets', ''].join('/'))
    end

    def repositories(paper_id)
      get(@api_project_root + ['papers', paper_id, 'repositories', ''].join('/'))
    end

    def get(url)
      http_response = HTTP.headers('Accept' => 'application/json').get(url)
      Response.new(http_response).tap do |response|
        raise response.error unless response.successful?
      end
    end
  end
end
