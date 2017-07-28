$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'rack/app'
require 'rack/app/db'

class App < Rack::App
  apply_extensions :sequel
end

run App