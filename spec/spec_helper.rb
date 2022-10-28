# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../require_app'
require_app

PAPERNAME = 'be-your-own-teacher-improve-the-performance'
CORRECT = YAML.safe_load(File.read('spec/fixtures/results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'paperswithcode_api'
