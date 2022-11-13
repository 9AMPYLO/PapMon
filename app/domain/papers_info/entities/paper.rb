# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

require_relative 'dataset'
require_relative 'repository'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Paper < Dry::Struct
      include Dry.Types
      attribute :id, Integer.optional
      attribute :origin_id, String.optional
      attribute :arxiv_id, String.optional
      attribute :primary_category, String.optional
      attribute :url_abs, String.optional
      attribute :title, String.optional
      # attribute :authors, Array.of(String).optional
      attribute :published, String.optional
      attribute :proceeding, String.optional
      attribute :repositories, Array.of(Repository).optional
      attribute :datasets, Array.of(Dataset).optional

      def to_attr_hash
        # to_hash.reject { |key, _| %i[id owner contributors].include? key }
        to_hash.except(:id, @repositories, @datasets)
      end
    end
  end
end
