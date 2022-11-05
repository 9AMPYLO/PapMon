# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Dataset < Dry::Struct
      include Dry.Types

      attribute :id, Integer.optional
      attribute :origin_id, String.optional
      attribute :name, String.optional
      attribute :url, String.optional
      def to_attr_hash
        # to_hash.reject { |key, _| %i[id owner contributors].include? key }
        to_hash.except(:id)
      end
    end
  end
end
