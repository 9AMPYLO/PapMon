# frozen_string_literal: true

require_relative 'datasets'
require_relative 'repositories'
module PapMon
  module Repository
    # Repository for Datasets
    class Papers
      def self.find_id(id)
        rebuild_entity Database::PaperOrm.first(id:)
      end

      def self.find_origin_id(origin_id)
        rebuild_entity Database::PaperOrm.first(origin_id:)
      end

      def self.find(entity)
        find_origin_id(entity.origin_id)
      end

      def self.find_url_abs(url_abs)
        rebuild_entity Database::PaperOrm.first(url_abs:)
      end

      def self.create(entity)
        raise 'Paper already exists' if find(entity)

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
          puts @entity.to_attr_hash
          Database::PaperOrm.create(@entity.to_attr_hash)
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
