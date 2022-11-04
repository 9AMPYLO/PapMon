# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:datasets) do
      primary_key :id

      String :origin_id, unique: true
      String :name
      String :url
    end
  end
end
