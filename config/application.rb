$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require_relative 'boot'

Bundler.require :default, ENV['RACK_ENV']

require 'byebug' if ['test', 'development'].include? ENV['RACK_ENV']

require_relative '../lib'
