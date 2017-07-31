class Rack::App::SeQueL::Runner

  def self.setup_command(command)
    command.class_eval do

      option '-a', '--allow_missing_migration_files', 'In some cases, you may want to allow a migration in the database that does not exist in the filesystem' do
        migration_config[:allow_missing_migration_files] = true
      end

      option '-c', '--current [CURRENT_VERION]', 'Set the current version of the database for the execution' do |current_database_version|
        migration_config[:current] = current_database_version
      end

      # option '-r', '--relative [MIGRATION_COUNT]', 'Run the given number of migrations, with a positive number being migrations to migrate up, and a negative number being migrations to migrate down (IntegerMigrator only).' do |value|
      #   migration_config[:relative] = value.to_i
      # end

      option '-t', '--target [TIMESTAMP]', 'The target version to which to migrate.  If not given, migrates to the maximum version.' do |target_version|
        migration_config[:target] = target_version
      end

      option '-m', '--path-to-migration-patches [DIR_PATH]', "set to check what directory should be used for db migrations (default: #{Rack::App::SeQueL::Migration::DEFAULT_DIRECTORY})" do |new_migration_directory|
        options[:migration_directory] = new_migration_directory
      end

      option '-v', '--verbose', 'set migration to be verbose instead of silent' do
        options[:verbose] = true
      end

      private

      def migration_config
        @migration_config ||= {}
      end

    end
  end

  attr_reader :code

  def initialize(options, migration_options)
    @code = 0
    @options = options
    @migration_options = migration_options
  end

  def run
    Sequel.extension(:migration)

    Rack::App::SeQueL.open_connection do |db|
      db.loggers << logger

      run_migrator(db, migration_directory, migration_config)
    end

    return @code
  end

  private

  def logger
    @logger ||= Logger.new(@options[:verbose] ? ::STDOUT : ::IO::NULL)
  end

  def migration_config
    @migration_config ||= {}
  end

  def migration_directory
    @options[:migration_directory] || Rack::App::SeQueL::Migration::DEFAULT_DIRECTORY
  end

  def run_migrator(db, directory, config)
    ::Sequel::Migrator.run(db, directory, config)
  rescue => ex
    logger.error(ex.message)
    @code = 1
  end
end
