$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app/models'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app/apis'))

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'app_initializer'
require 'boot'

Bundler.require :default, ENV['RACK_ENV']

if ['test', 'development'].include? ENV['RACK_ENV']
  require 'byebug'
  require 'factory_girl'
end

load_modules
