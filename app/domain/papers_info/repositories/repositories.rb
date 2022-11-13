# frozen_string_literal: true

module PapMon
  module Repository
    # Repository for Datasets
    class Repositories
      def self.find_id(id)
        rebuild_entity Database::RepositoryOrm.first(id:)
      end

      def self.find_origin_id(origin_id)
        rebuild_entity Database::RepositoryOrm.first(origin_id:)
      end

      def self.find_url(url)
        rebuild_entity Database::RepositoryOrm.first(url:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        PapMon::Entity::Repository.new(
          id: db_record.id,
          url: db_record.url
        )
      end

      def self.rebuild_many(db_records)
        db_records.map { |db_record| Repositories.rebuild_entity(db_record) }
      end

      def self.db_find_or_create(entity)
        Database::RepositoryOrm.find_or_create(entity.to_attr_hash)
      end
    end
  end
end
