# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:datasets) do
      primary_key :id

      # Integer :origin_id, unique: true
      String :name
      String :url
    end
  end
end
