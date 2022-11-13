# frozen_string_literal: true

require_relative 'helpers/spec_helper'
require_relative 'helpers/vcr_helper'

describe 'Test Paperswithcode API Library' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_paperswithcode
    VcrHelper.configure_vcr_for_arxiv
  end

  after do
    VcrHelper.eject_vcr
    VcrHelper.eject_vcr
  end

  describe 'Arxiv API information' do
    it 'HAPPY: should get the latest paper from arxiv' do
      arxiv = PapMon::Arxiv::ArxivMapper.new.newest10
      arxiv = arxiv[0]
      _(arxiv.arxiv_id).must_equal ARXIV_CORRECT['arxiv_id']
      _(arxiv.primary_category).must_equal ARXIV_CORRECT['primary_category']
    end
  end

  describe 'Paper information' do
    it 'HAPPY: should provide correct paper information' do
      paper = PapMon::PapersWithCode::PaperMapper.new.find(LATEST_ARXIV)
      _(paper.origin_id).must_equal PWC_CORRECT['id']
      _(paper.arxiv_id).must_equal PWC_CORRECT['arxiv_id']
      _(paper.primary_category).must_equal PWC_CORRECT['primary_category']
      _(paper.url_abs).must_equal PWC_CORRECT['url_abs']
      _(paper.title).must_equal PWC_CORRECT['title']
      _(paper.published).must_equal PWC_CORRECT['published']
      if PWC_CORRECT['proceeding'].nil?
        _(paper.proceeding).must_be_nil
      else
        _(paper.proceeding).must_equal PWC_CORRECT['proceeding']
      end
    end
  end

  describe 'Dataset information' do
    before do
      @paper = PapMon::PapersWithCode::PaperMapper.new.find(LATEST_ARXIV)
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
      _(datasets.count).must_equal PWC_CORRECT['datasets'].count
      datasets_names = datasets.map(&:name)
      correct_datasets_names = PWC_CORRECT['datasets'].map { |d| d['name'] }
      _(datasets_names).must_equal correct_datasets_names
    end
  end

  describe 'Repository information' do
    before do
      @paper = PapMon::PapersWithCode::PaperMapper.new.find(LATEST_ARXIV)
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
      _(repos.count).must_equal PWC_CORRECT['repositories'].count
      repos_urls = repos.map(&:url)
      correct_repos_urls = PWC_CORRECT['repositories'].map { |d| d['url'] }
      _(repos_urls).must_equal correct_repos_urls
    end
  end
end
