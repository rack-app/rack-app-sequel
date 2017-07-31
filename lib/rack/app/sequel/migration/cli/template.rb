command 'db:migration:create' do
  description 'create migration patch'

  option '-m', '--path-to-migration-patches [DIR_PATH]', "set to check what directory should be used for db migrations (default: #{Rack::App::SeQueL::Migration::DEFAULT_DIRECTORY})" do |string|
    options[:migration_directory] = string
  end

  action do |*name_parts|
    options[:migration_directory] ||= Rack::App::SeQueL::Migration::DEFAULT_DIRECTORY
    name = name_parts.join('_')

    require 'fileutils'
    FileUtils.mkdir_p(options[:migration_directory])
    timestamp = Time.now.to_i
    filebasename = [timestamp.to_s, name].join('_') + '.rb'
    file_path = File.join(options[:migration_directory], filebasename)
    File.write(file_path, Rack::App::SeQueL::Migration::TEMPLATE)

    STDOUT.puts(file_path)
  end
end
