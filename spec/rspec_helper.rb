current_path = File.join(File.dirname(__FILE__), "..", "config")
puts "cur: #{current_path}"
$:.unshift current_path
require_relative '../config/environment'
require 'rspec'
require 'database_cleaner'
ENV['RACK_ENV'] = 'test'


RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
