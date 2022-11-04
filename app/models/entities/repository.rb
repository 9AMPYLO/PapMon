# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Repository < Dry::Struct
      include Dry.Types

      attribute :id, String.optional
      attribute :origin_id, String.optional
      attribute :repo_url, String.optional
    end
  end
end
