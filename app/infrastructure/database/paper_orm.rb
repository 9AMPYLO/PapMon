# frozen_string_literal: true

module PapMon
  module Database
    # Paper ORM
    class PaperOrm < Sequel::Model(:papers)
      one_to_many :paper_repos,
                  class: :'PapMon::Database::RepositoryOrm',
                  key: :paper_id
      many_to_many :papers,
                   class: :'PapMon::Database::DatasetOrm',
                   join_table: :papers_datasets,
                   left_key: :paper_id, right_key: :dataset_id
      plugin :timestamps, update_on_create: true
    end
  end
end
