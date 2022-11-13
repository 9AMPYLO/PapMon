# frozen_string_literal: true

# Require all files in the lib directory
def require_app(folders = %w[infrastructure domain views controllers])
  app_list = Array(folders).map { |folder| "app/#{folder}" }
  full_list = ['config', app_list].flatten.join(',')

  Dir.glob("./{#{full_list}}/**/*.rb").each do |file|
    # puts "Loading #{file}"
    require file
  end
end
