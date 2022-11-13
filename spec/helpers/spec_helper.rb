# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../../require_app'
require_app

system('ruby spec/helpers/get_latest_paper.rb')
ARXIV_CORRECT = YAML.safe_load(File.read('spec/fixtures/arxiv.yml'))
PWC_CORRECT = YAML.safe_load(File.read('spec/fixtures/paperswithcode.yml'))
LATEST_ARXIV = PapMon::Arxiv::ArxivMapper.new.newest10[0]
