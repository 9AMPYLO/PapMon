# frozen_string_literal: true

require_relative 'dataset'

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Repository < Dry::Struct
      include Dry.Types

      attribute :id, String.optional
      attribute :arxiv_id, String.optional
      attribute :url_abs, String.optional
      attribute :title, String.optional
      attribute :authors, String.optional
      attribute :published, String.optional
      attribute :proceeding, String.optional
      attribute :repositories, Array.of(Repository).optional
      attribute :datasets, Array.of(Dataset).optional
    end
  end
end
