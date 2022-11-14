# frozen_string_literal: true

module PapMon
  module Database
    # Paper ORM
    class PaperOrm < Sequel::Model(:papers)
      one_to_many :repositories,
                  class: :'PapMon::Database::RepositoryOrm',
                  key: :paper_id
      many_to_many :datasets,
                   class: :'PapMon::Database::DatasetOrm',
                   join_table: :papers_datasets,
                   left_key: :paper_id, right_key: :dataset_id
      plugin :timestamps, update_on_create: true
      def self.find_or_create(paper_info)
        first(origin_id: paper_info[:origin_id]) || create(paper_info)
      end
    end
  end
end
