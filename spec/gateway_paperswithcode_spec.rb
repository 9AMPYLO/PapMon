# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Test Paperswithcode API Library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Paper information' do
    it 'HAPPY: should provide correct paper information' do
      # paper = PapMon::PapersWithCodeApi.new.paper(PAPERNAME)
      paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERNAME)
      _(paper.id).must_equal CORRECT['id']
      _(paper.arxiv_id).must_equal CORRECT['arxiv_id']
      _(paper.url_abs).must_equal CORRECT['url_abs']
      _(paper.title).must_equal CORRECT['title']
      _(paper.authors).must_equal CORRECT['authors']
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
      # @paper = PapMon::PapersWithCodeApi.new.paper(PAPERNAME)
      @paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERNAME)
    end

    it 'HAPPY: should recognize datasets' do
      _(@paper.datasets).must_be_kind_of Array
    end

    it 'HAPPY: should recognize every dataset' do
      _(@paper.datasets).map do |dataset|
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
      @paper = PapMon::PapersWithCode::PaperMapper.new.find(PAPERNAME)
    end

    it 'HAPPY: should recognize repositories' do
      _(@paper.repositories).must_be_kind_of Array
    end

    it 'HAPPY: should recognize every repository' do
      _(@paper.repositories).map do |repository|
        _(repository).must_be_kind_of PapMon::Entity::Repository
      end
    end

    it 'HAPPY: should provide correct repository information' do
      repos = @paper.repositories
      _(repos.count).must_equal CORRECT['repositories'].count
      repos_names = repos.map(&:repo_name)
      correct_repos_names = CORRECT['repositories'].map { |d| d['name'] }
      _(repos_names).must_equal correct_repos_names
    end
  end
end
