# frozen_string_literal: true

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Dataset < Dry::Struct
      include Dry.Types

      attribute :id, Strict::String
      attribute :name, Strict::String
      arrtubute :full_name, String.optional
      attribute :url, Strict::String
    end
  end
end
