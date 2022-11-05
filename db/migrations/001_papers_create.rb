# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:papers) do
      primary_key :id

      String :origin_id, unique: true
      String :arxiv_id, unique: true
      String :url_abs
      String :title
      String :authors
      Date :published
      String :proceeding
    end
  end
end
