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

      # def to_attr_hash
      #   # to_hash.reject { |key, _| %i[id owner contributors].include? key }
      #   to_hash.except(:arxiv_id, :primary_category)
      # end
    end
  end
end
