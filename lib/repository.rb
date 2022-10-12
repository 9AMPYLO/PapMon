# frozen_string_literal: true

# module PapMon
module PapMon
  # Repository class
  class Repository
    def initialize(repo_data)
      @repo_data = repo_data
    end

    def repo_url
      @repo_data['url']
    end

    def owner
      @repo_data['owner']
    end

    def repo_name
      @repo_data['name']
    end
  end
end
