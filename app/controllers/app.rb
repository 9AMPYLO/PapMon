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
        papers = Repository::For.klass(Entity::Paper).new.all
        view 'home', locals: { papers: }
      end

      routing.on 'paper' do
        routing.is do
          # POST /paper/
          routing.post do
            id = routing.params['id']
            paperswithcode_paper = PapersWithCode::PaperMapper.new.find(id)
            Repository::For.klass(Entity::Paper).create(paperswithcode_paper)
            routing.halt 400, 'Missing paper id' unless id
            routing.redirect "paper/#{id}"
          end
        end

        routing.on String do |id|
          # GET /paper/[id]
          routing.get do
            # paperswithcode_paper = PapersWithCode::PaperMapper.new.find(id)
            paperswithcode_paper = Repository::For.klass(Entity::Paper).find_origin_id(id)
            view 'paper', locals: { paper: paperswithcode_paper }
          end
        end
      end
    end
  end
end
