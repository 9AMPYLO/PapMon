# frozen_string_literal: true

module PapMon
  module PapersWithCode
    # Paper Mapper for PapersWithCode API
    class PaperMapper
      def initialize(gateway_class = PapMon::PapersWithCodeApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find(paper_name)
        data = @gateway.paper_data(paper_name)
        build_entity(data)
      end

      def build_entity(data)
        DataMapper.new(data, @gateway_class).build_entity
      end
    end

    # Data Mapper for PaperMapper
    class DataMapper
      def initialize(data, gateway_class)
        @data = data
        @dataset_mapper = DatasetMapper.new(gateway_class)
        @repository_mapper = RepositoryMapper.new(gateway_class)
      end

      def build_entity
        PapMon::Entity::Paper.new(
          id:,
          arxiv_id:,
          url_abs:,
          title:,
          authors:,
          published:,
          proceeding:,
          repositories:,
          datasets:
        )
      end

      def id
        @data['id']
      end

      def arxiv_id
        @data['arxiv_id']
      end

      def url_abs
        @data['url_abs']
      end

      def title
        @data['title']
      end

      def authors
        @data['authors']
      end

      def published
        @data['published']
      end

      def proceeding
        @data['proceeding']
      end

      def repositories
        @repository_mapper.load_several(@data['repositories'])
      end

      def datasets
        @dataset_mapper.load_several(@data['datasets'])
      end
    end
  end
end
