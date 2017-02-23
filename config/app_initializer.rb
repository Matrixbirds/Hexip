module AppInitializer
  MODELS = Dir['./app/models/*.rb'].freeze
  APIS = Dir['./app/apis/*.rb'].freeze

  def load_modules
    deps
    setup_db_connection
    load_models
    load_apis
    load_app
  end

  def load_models
    MODELS.each &proc{ |model| require model }
  end

  def deps
    require 'yaml'
    require 'active_record'
    require 'kaminari/core'
  end

  def load_apis
    APIS.each &proc{ |api| require api }
  end

  def load_app
    require File.join(File.dirname(__FILE__), '../lib/application')
  end

  def setup_db_connection
    db_config = YAML::load_file(File.join(File.dirname(__FILE__), 'database.yml'))[ENV['RACK_ENV']]
    ActiveRecord::Base.establish_connection(db_config)
  end
end

include AppInitializer
