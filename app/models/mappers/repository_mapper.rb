# frozen_string_literal: true

module PapMon
  module PapersWithCode
    # Repository Mapper for PapersWithCode API
    class RepositoryMapper
      def initialize(gateway_class)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def load_several(paper_id)
        @gateway.repositories_data(paper_id)['results'].map do |repo|
          RepositoryMapper.build_entity(repo)
        end
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Data Mapper for RepositoryMapper
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          PapMon::Entity::Repository.new(
            repo_url:,
            owner:,
            repo_name:
          )
        end

        def repo_url
          @data['url']
        end

        def owner
          @data['owner']
        end

        def repo_name
          @data['name']
        end
      end
    end
  end
end