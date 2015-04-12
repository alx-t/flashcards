namespace :secrets do
  desc "Rename secrets.yml for production on heroku"
  task :rename do
    `cp config/secrets.dev.yml config/secrets.yml`
  end
end
