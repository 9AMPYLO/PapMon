# frozen_string_literal: true

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Repository < Dry::Struct
      include Dry.Types

      attribute :repo_url, Strict::String
      attribute :owner, Strict::String
      attribute :repo_name, Strict::String
    end
  end
end
