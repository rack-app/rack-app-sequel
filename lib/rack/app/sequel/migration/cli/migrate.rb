command 'db:migrate' do

  description 'Migrates the supplied database using the migration files in the specified directory'
  Rack::App::SeQueL::Runner.setup_command(self)

  action do
    exit(Rack::App::SeQueL::Runner.new(options, migration_config).run)
  end

end
