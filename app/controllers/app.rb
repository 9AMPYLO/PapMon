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
        view 'home'
      end

      routing.on 'paper' do
        routing.is do
          # POST /project/
          routing.post do
            id = 'be-your-own'
            routing.redirect "paper/#{id}"
          end
        end
        view 'paper'
      end
    end
  end
end