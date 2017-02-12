$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app/models'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

class << self
  def setup_db_connection
    require 'yaml'
    require 'active_record'
    db_config = YAML::load_file(File.join(File.dirname(__FILE__), 'database.yml'))
    ActiveRecord::Base.establish_connection(db_config)
  end
end

require_relative 'boot'

Bundler.require :default, ENV['RACK_ENV']

require 'byebug' if ['test', 'development'].include? ENV['RACK_ENV']

setup_db_connection
require 'article'

require_relative '../lib'
