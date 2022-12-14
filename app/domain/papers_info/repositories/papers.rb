# frozen_string_literal: true

require_relative 'datasets'
require_relative 'repositories'
module PapMon
  module Repository
    # Repository for Datasets
    class Papers
      def self.all
        Database::PaperOrm.all.map { |db_paper| rebuild_entity(db_paper) }
      end

      def self.find_id(id)
        rebuild_entity Database::PaperOrm.first(id:)
      end

      def self.find_origin_id(origin_id)
        rebuild_entity Database::PaperOrm.first(origin_id:)
      end

      def self.find_arxiv_id(arxiv_id)
        rebuild_entity Database::PaperOrm.first(arxiv_id:)
      end

      def self.find(entity)
        find_origin_id(entity.origin_id)
      end

      def self.find_url_abs(url_abs)
        rebuild_entity Database::PaperOrm.first(url_abs:)
      end

      def self.create(entity) # rubocop:disable Metrics/MethodLength
        if find(entity)
          return PapMon::Entity::Paper.new(
            id: 0,
            origin_id: entity.origin_id,
            arxiv_id: entity.arxiv_id,
            primary_category: entity.primary_category,
            url_abs: entity.url_abs,
            title: entity.title,
            published: entity.published,
            proceeding: entity.proceeding,
            repositories: entity.repositories,
            datasets: entity.datasets
          )
        end

        db_paper = PersistPaper.new(entity).call
        rebuild_entity(db_paper)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        PapMon::Entity::Paper.new(
          db_record.to_hash.merge(
            datasets: Datasets.rebuild_many(db_record.datasets),
            repositories: Repositories.rebuild_many(db_record.repositories)
          )
        )
      end

      # Helper class to persist paper and its members to database
      class PersistPaper
        def initialize(entity)
          @entity = entity
        end

        def create_paper
          Database::PaperOrm.find_or_create(@entity.to_attr_hash)
        end

        def call
          create_paper.tap do |db_paper|
            @entity.datasets.each do |dataset|
              db_paper.add_dataset(Datasets.db_find_or_create(dataset))
            end
            @entity.repositories.each do |repository|
              db_paper.add_repository(Repositories.db_find_or_create(repository))
            end
          end
        end
      end
    end
  end
end
