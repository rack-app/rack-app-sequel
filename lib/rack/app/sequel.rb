require 'sequel'
require 'rack/app'
module Rack::App::SeQueL
  require 'rack/app/db/ext'
  require 'rack/app/db/version'
  require 'rack/app/db/migration'

  def open_connection
    Sequel.connect(ENV.fetch('DATABASE_URL'))
  end

  module_function :connection
end
