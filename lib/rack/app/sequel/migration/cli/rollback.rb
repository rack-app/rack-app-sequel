command 'db:rollback' do
  description "Rollback the database N steps (you can specify the version with `db:rollback [STEP_COUNT]`"

  Rack::App::SeQueL::Runner.setup_command(self, :target)

  action do |step=1|
    step = Integer(step)

    if step == 0
      migration_config[:target] = 0
    end

    Rack::App::SeQueL.open_connection do |connection|
        row = connection[:schema_migrations]
                .order(Sequel.desc(:filename))
                .offset(step).first

        unless row.nil?
          migration_config[:target] = Integer(row[:filename].match(/^([\d]+)/)[0])
        end
    end unless migration_config[:target]

    migration_config[:target] || abort("target version not found")

    exit(Rack::App::SeQueL::Runner.new(options, migration_config).run)
  end

end
