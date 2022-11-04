# frozen_string_literal: true

module PapMon
  module Database
    # Paper ORM
    class DatasetOrm < Sequel::Model(:datasets)
      many_to_many :papers,
                   class: :'PapMon::Database::PaperOrm',
                   join_table: :papers_datasets,
                   left_key: :dataset_id, right_key: :paper_id
      plugin :timestamps, update_on_create: true
      def self.find_or_create(dataset_info)
        first(id: dataset_info[:id]) || create(dataset_info)
      end
    end
  end
end
