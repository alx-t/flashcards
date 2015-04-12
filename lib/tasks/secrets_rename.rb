namespace :secrets do
  desc "Rename secrets.yml for production on heroku"
  task :rename do
    run "cp config/secrets.dev.yml config/secrets.yml"
  end
end