# frozen_string_literal: true

module PapMon
  module PapersWithCode
    # Paper Mapper for PapersWithCode API
    class PaperMapper
      def initialize(gateway_class = PapMon::PapersWithCodeApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def find(arxiv_entity)
        data = @gateway.paper_data(arxiv_entity.arxiv_id)['results'][0]
        data.merge!(primary_category: arxiv_entity.primary_category)
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
          id: nil,
          origin_id:,
          arxiv_id:,
          primary_category:,
          url_abs:,
          title:,
          authors:,
          published:,
          proceeding:,
          repositories:,
          datasets:
        )
      end

      def origin_id
        @data['id']
      end

      def arxiv_id
        @data['arxiv_id']
      end

      def primary_category
        @data[:primary_category]
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
        @repository_mapper.load_several(@data['id'])
      end

      def datasets
        @dataset_mapper.load_several(@data['id'])
      end
    end
  end
end
