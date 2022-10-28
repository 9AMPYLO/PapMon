# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Repository < Dry::Struct
      include Dry.Types

      attribute :repo_url, String.optional
      attribute :owner, String.optional
      attribute :repo_name, String.optional
    end
  end
end
