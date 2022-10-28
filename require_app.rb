# frozen_string_literal: true

# Require all files in the lib directory
def require_app
  Dir.glob('./lib/**/*.rb').each { |file| require file }
end
