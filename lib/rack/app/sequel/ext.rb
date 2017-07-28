Rack::App::Extension.register :sequel do
  cli(&Rack::App::SeQueL::Migration::CLI)
end
