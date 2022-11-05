# frozen_string_literal: true

require_relative 'datasets'
require_relative 'repositories'
require_relative 'papers'
module PapMon
  module Repository
    # Finds the right repository for an entity object or class
    module For
      ENTITY_REPOSITORY = {
        Entity::Paper => Repository::Papers,
        Entity::Dataset => Repository::Datasets,
        Entity::Repository => Repository::Repositories
      }.freeze

      def self.klass(entity_klass)
        ENTITY_REPOSITORY[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_REPOSITORY[entity_object.class]
      end
    end
  end
end
