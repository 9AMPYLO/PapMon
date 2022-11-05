# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:papers_datasets) do
      primary_key [:paper_id, :dataset_id] # rubocop:disable Style/SymbolArray
      foreign_key :paper_id, :papers
      foreign_key :dataset_id, :datasets

      index [:paper_id, :dataset_id] # rubocop:disable Style/SymbolArray
    end
  end
end
