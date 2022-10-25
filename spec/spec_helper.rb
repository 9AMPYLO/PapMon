# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'
require_relative '../lib/paperswithcode_api'

PAPERNAME = 'be-your-own-teacher-improve-the-performance'
CORRECT = YAML.safe_load(File.read('spec/fixtures/results.yml'))
# CONFIG = YAML.safe_load(File.read('config/secrets.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'paperswithcode_api'
