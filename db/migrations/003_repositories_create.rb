# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:repositories) do
      primary_key :id

      String :origin_id, unique: true
      String :url, unique: true
    end
  end
end
