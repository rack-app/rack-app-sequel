require 'rack/app/sequel'
file_path = File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'VERSION')
Rack::App::SeQueL::VERSION = File.read(file_path).strip
