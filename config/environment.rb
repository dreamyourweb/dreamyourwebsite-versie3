# Load the rails application
require File.expand_path('../application', __FILE__)

# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)
META_CONFIG = YAML.load_file("#{Rails.root}/config/meta.yml")

# Initialize the rails application
Dywsite2::Application.initialize!