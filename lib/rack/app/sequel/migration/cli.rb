Rack::App::SeQueL::Migration::CLI = lambda do

    command "db:migrate" do
      description 'Run migrations'

      option '-v', '--version [TIMESTAMP]', 'set to what db migration version number should db to be set' do |string|
        options[:version] = string
      end

      option '--allow-missing-migration-files', 'In some cases, you may want to allow a migration in the database that does not exist in the filesystem' do
        options[:allow_missing_migration_files] = true
      end

      option '-m', '--path-to-migration-patches [DIR_PATH]', "set to check what directory should be used for db migrations (default: #{Rack::App::SeQueL::Migration::DEFAULT_DIRECTORY})" do |string|
        options[:migration_directory] = string
      end

      action do

        options[:migration_directory] ||= Rack::App::SeQueL::Migration::DEFAULT_DIRECTORY

        Sequel.extension(:migration)
        db = Rack::App::SeQueL.open_connection
        db = Sequel.connect(ENV.fetch('DATABASE_URL'))

        migration_config = {}
        if options[:allow_missing_migration_files]
          migration_config[:allow_missing_migration_files]= true
        end

        if options[:version]
          STDOUT.puts "Migrating to version #{options[:version]}"
          migration_config[:target]= options[:version].to_i
        end

        Sequel::Migrator.run(db, options[:migration_directory], migration_config)

        STDOUT.puts('Migration completed')
      end

    end

    command "db:migration:create" do
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

end
