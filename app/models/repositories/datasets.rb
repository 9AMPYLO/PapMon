# frozen_string_literal: true

module PapMon
  module Repository
    # Repository for Datasets
    class Datasets
      def self.find_id(id)
        rebuild_entity Database::DatasetOrm.first(id:)
      end

      def self.find_origin_id(origin_id)
        rebuild_entity Database::DatasetOrm.first(origin_id:)
      end

      def self.find_name(dataset_name)
        rebuild_entity Database::DatasetOrm.first(name: dataset_name)
      end

      def self.find_url(url)
        rebuild_entity Database::DatasetOrm.first(url:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        PapMon::Entity::Dataset.new(
          id: db_record.id,
          origin_id: db_record.origin_id,
          name: db_record.name,
          url: db_record.url
        )
      end

      def self.rebuild_many(db_records)
        db_records.map { |db_record| Datasets.rebuild_entity(db_record) }
      end

      def self.db_find_or_create(entity)
        Database::DatasetOrm.find_or_create(entity.to_attr_hash)
      end
    end
  end
end
