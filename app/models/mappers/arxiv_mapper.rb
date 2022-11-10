# frozen_string_literal: true

module PapMon
  module Arxiv
    # Paper Mapper for PapersWithCode API
    class ArxivMapper
      def initialize(gateway_class = PapMon::ArxivApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def newest10
        data = @gateway.arxiv_paper
        build_entity(data)
      end

      def build_entity(data)
        DataMapper.new(data).build_entity
      end
    end

    # Data Mapper for PaperMapper
    class DataMapper
      def initialize(data)
        @data = data
      end

      def build_entity
        PapMon::Entity::Paper.new(
          arxiv_id:,
          primary_category:
        )
      end

      def arxiv_id
        @data['arxiv_id']
      end

      def primary_category
        @data['primary_category']
      end
    end
  end
end
