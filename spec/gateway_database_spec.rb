# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Paperswithcode API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_paperswithcode
    VcrHelper.configure_vcr_for_arxiv
  end

  after do
    VcrHelper.eject_vcr
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store project' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save project from PapersWithCode to database' do
      paper = PapMon::PapersWithCode::PaperMapper.new.find(LATEST_ARXIV)
      rebuilt = PapMon::Repository::For.entity(paper).create(paper)

      _(rebuilt.origin_id).must_equal paper.origin_id
      _(rebuilt.arxiv_id).must_equal paper.arxiv_id
      _(rebuilt.primary_category).must_equal paper.primary_category
      _(rebuilt.url_abs).must_equal paper.url_abs
      _(rebuilt.title).must_equal paper.title
      _(rebuilt.published).must_equal paper.published
      _(rebuilt.datasets.count).must_equal paper.datasets.count
      if paper.proceeding.nil?
        _(rebuilt.proceeding).must_be_nil
      else
        _(rebuilt.proceeding).must_equal paper.proceeding
      end

      paper.datasets.each do |dataset|
        found = rebuilt.datasets.find do |d|
          d.origin_id == dataset.origin_id
        end
        _(found.name).must_equal dataset.name
      end
    end
  end
end
