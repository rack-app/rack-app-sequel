require 'sequel'
require 'rack/app'
module Rack::App::SeQueL

  require 'rack/app/sequel/ext'
  require 'rack/app/sequel/runner'
  require 'rack/app/sequel/version'
  require 'rack/app/sequel/migration'

  def open_connection(&block)
    Sequel.connect(ENV.fetch('DATABASE_URL'), &block)
  end

  module_function :open_connection

end
