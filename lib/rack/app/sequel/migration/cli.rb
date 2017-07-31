Rack::App::SeQueL::Migration::CLI = lambda do
  Dir.glob(File.join(File.dirname(__FILE__), 'cli', '*.rb')).each do |file_path|
    next if File.directory?(file_path)

    instance_eval(File.read(file_path))
  end
end
