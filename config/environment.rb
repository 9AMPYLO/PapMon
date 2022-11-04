# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'figaro'
require 'sequel'

module PapMon
  # Configuration for the App
  class App < Roda
    plugin :environments

    # rubocop:disable Lint/ConstantDefinitionInBlock
    configure do
      Figaro.application = Figaro::Application.new(
        environment:,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load

      def self.config = Figaro.env
      configure :development do
        ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
      end

      # Database Setup
      DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
      def self.DB = DB # rubocop:disable Naming/MethodName
    end
    # rubocop:enable Lint/ConstantDefinitionInBlock
  end
end
