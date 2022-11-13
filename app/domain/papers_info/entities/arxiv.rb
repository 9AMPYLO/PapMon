# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Arxiv < Dry::Struct
      include Dry.Types

      attribute :arxiv_id, String.optional
      attribute :primary_category, String.optional
    end
  end
end
