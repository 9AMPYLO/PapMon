# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Dataset < Dry::Struct
      include Dry.Types

      attribute :id, String.optional
      attribute :name, String.optional
      attribute :full_name, String.optional
      attribute :url, String.optional
    end
  end
end
