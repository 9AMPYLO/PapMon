# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Paperswithcode API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_paperswithcode
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store project' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save project from PapersWithCode to database' do
      paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERID)
      rebuilt = PapMon::Repository::For.entity(paper).create(paper)

      _(rebuilt.origin_id).must_equal paper.origin_id
      _(rebuilt.arxiv_id).must_equal paper.arxiv_id
      _(rebuilt.url_abs).must_equal paper.url_abs
      _(rebuilt.title).must_equal paper.title
      _(rebuilt.published).must_equal paper.published
      _(rebuilt.proceeding).must_equal paper.proceeding
      _(rebuilt.datasets.count).must_equal paper.datasets.count

      paper.datasets.each do |dataset|
        found = rebuilt.datasets.find do |d|
          d.origin_id == dataset.origin_id
        end
        _(found.name).must_equal dataset.name
      end
    end
  end
end
