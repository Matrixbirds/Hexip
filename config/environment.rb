ENV['RACK_ENV'] ||= 'development'
ENV['HOST'] = nil
require_relative 'application'
