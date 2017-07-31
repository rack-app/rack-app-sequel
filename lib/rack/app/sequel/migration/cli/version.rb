# command 'db:schema:version' do
#   description 'prints current schema version'

#   action do
#     Sequel.extension(:migration)
#     db = Rack::App::SeQueL.open_connection
#     db = Sequel.connect(ENV.fetch('DATABASE_URL'))

#     version = if db.tables.include?(:schema_info)
#                 db[:schema_info].first[:version]
#     end || 0

#     STDOUT.puts("Schema Version: #{version}")
#   end
# end
