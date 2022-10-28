# frozen_string_literal: true

# Require all the files in the lib directory
def require_app
  Dir.glob('./lib/**/*.rb').each do |file|
    require file
  end
end
