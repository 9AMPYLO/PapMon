# frozen_string_literal: true

require_relative 'helpers/spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Test Paperswithcode API Library' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_paperswithcode
    VcrHelper.configure_vcr_for_arxiv
    DatabaseHelper.wipe_database
  end

  after do
    VcrHelper.eject_vcr
    VcrHelper.eject_vcr
  end

  describe 'HAPPY: should get accurate count of papers' do
    it 'HAPPY: should get accurate count of papers' do
      root = PapMon::Arxiv::PapersMapper.new.newest10
      _(root.category_and_count.count).must_equal 10
    end
  end
end
