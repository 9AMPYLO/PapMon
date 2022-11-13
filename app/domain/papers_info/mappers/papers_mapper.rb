# frozen_string_literal: true

module PapMon
  module Arxiv
    # Paper Mapper for PapersWithCode API
    class PapersMapper
      def initialize(gateway_class = PapMon::ArxivApi)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def newest10
        data = @gateway.arxiv_paper
        data.map! do |paper|
          build_arxiv_entity(paper)
        end
        build_papers_entity(data)
      end

      def build_arxiv_entity(paper)
        DataMapper.new(paper).build_entity
      end

      def build_papers_entity(arxiv_entities)
        PapMon::Entity::Papers.new(papers: paper_summaries(arxiv_entities))
      end
      def paper_summaries(arxiv_entities)
        arxiv_entities.map do |arxiv_entity|
          PapersWithCode::PaperMapper.new.find(arxiv_entity)
        end
      end
    end

    # Data Mapper for PaperMapper
    class DataMapper
      def initialize(data)
        @data = data
      end

      def build_entity
        PapMon::Entity::Arxiv.new(
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