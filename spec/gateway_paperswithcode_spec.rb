# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'

describe 'Test Paperswithcode API Library' do
  before do
    VcrHelper.configure_vcr_for_paperswithcode
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Paper information' do
    it 'HAPPY: should provide correct paper information' do
      paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERID)
      _(paper.origin_id).must_equal CORRECT['id']
      _(paper.arxiv_id).must_equal CORRECT['arxiv_id']
      _(paper.url_abs).must_equal CORRECT['url_abs']
      _(paper.title).must_equal CORRECT['title']
      _(paper.published).must_equal CORRECT['published']
      _(paper.proceeding).must_equal CORRECT['proceeding']
    end

    it 'SAD: should raise exception on invalid paper name' do
      _(proc {
          PapMon::PapersWithCode::PaperMapper.new.find('be-your-own-teacher')
        }).must_raise PapMon::PapersWithCodeApi::Response::NotFound
    end
  end

  describe 'Dataset information' do
    before do
      @paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERID)
    end

    it 'HAPPY: should recognize datasets' do
      _(@paper.datasets).must_be_kind_of Array
    end

    it 'HAPPY: should recognize every dataset' do
      @paper.datasets.each do |dataset|
        _(dataset).must_be_kind_of PapMon::Entity::Dataset
      end
    end

    it 'HAPPY: should provide correct dataset information' do
      datasets = @paper.datasets
      _(datasets.count).must_equal CORRECT['datasets'].count
      datasets_names = datasets.map(&:name)
      correct_datasets_names = CORRECT['datasets'].map { |d| d['name'] }
      _(datasets_names).must_equal correct_datasets_names
    end
  end

  describe 'Repository information' do
    before do
      @paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERID)
    end

    it 'HAPPY: should recognize repositories' do
      _(@paper.repositories).must_be_kind_of Array
    end

    it 'HAPPY: should recognize every repository' do
      @paper.repositories.map do |repository|
        _(repository).must_be_kind_of PapMon::Entity::Repository
      end
    end

    it 'HAPPY: should provide correct repository information' do
      repos = @paper.repositories
      _(repos.count).must_equal CORRECT['repositories'].count
      repos_urls = repos.map(&:url)
      correct_repos_urls = CORRECT['repositories'].map { |d| d['url'] }
      _(repos_urls).must_equal correct_repos_urls
    end
  end
end
