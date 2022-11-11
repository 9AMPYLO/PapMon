# frozen_string_literal: true

require_relative 'spec_helper'

arxiv_paper = PapMon::Arxiv::ArxivMapper.new.newest10
arxiv_paper.each do |each_paper|
  # Get paper from PapersWithCode
  paperswithcode_paper = PapMon::PapersWithCode::PaperMapper.new.find(each_paper)
  # Add paper to database
  puts(PapMon::Repository::For.entity(paperswithcode_paper).create(paperswithcode_paper))
end
