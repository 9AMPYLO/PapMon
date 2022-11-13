# frozen_string_literal: true

require 'roda'
require 'slim'

module PapMon
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        papers = Repository::For.klass(Entity::Paper).all
        view 'home', locals: { papers: }
      end

      routing.on 'arxiv' do
        routing.is do
          # POST /paper/
          routing.post do
            arxiv_paper = Arxiv::PapersMapper.new.newest10

            arxiv_paper.papers.each do |each_paper|
              Repository::For.entity(each_paper).create(each_paper)
            end

            arxiv_paper = arxiv_paper.category_and_count


            puts arxiv_paper['paperOTHER'].class


            view 'arxiv', locals: { 
              paperCV: arxiv_paper['paperCV'], nCV: arxiv_paper['nCV'],
              paperAI: arxiv_paper['paperAI'], nAI: arxiv_paper['nAI'],
              paperLG: arxiv_paper['paperLG'], nLG: arxiv_paper['nLG'],
              paperCL: arxiv_paper['paperCL'], nCL: arxiv_paper['nCL'],
              paperNE: arxiv_paper['paperNE'], nNE: arxiv_paper['nNE'],
              paperML: arxiv_paper['paperML'], nML: arxiv_paper['nML'],
              paperOTHER: arxiv_paper['paperOTHER'], nOTHER: arxiv_paper['nOTHER'],
            }
          end
        end
      end

      routing.on 'paper' do
        routing.is do
          # POST /paper/
          routing.post do
            id = routing.params['arxiv_id']
            puts id
            routing.redirect "paper/#{id}"
          end
        end

        routing.on String do |id|
          # GET /paper/[id]
          routing.get do
            paperswithcode_paper = Repository::For.klass(Entity::Paper).find_arxiv_id(id)
            view 'paper', locals: { paper: paperswithcode_paper }
          end
        end
      end
    end
  end
end
