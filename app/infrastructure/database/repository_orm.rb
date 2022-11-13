# frozen_string_literal: true

module PapMon
  module Database
    # Paper ORM
    class RepositoryOrm < Sequel::Model(:repositories)
      many_to_one :paper,
                  class: :'PapMon::Database::PaperOrm'

      plugin :timestamps, update_on_create: true
      def self.find_or_create(repo_info)
        first(url: repo_info[:url]) || create(repo_info)
      end
    end
  end
end
