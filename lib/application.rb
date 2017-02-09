require_relative 'router'
require_relative 'abstract_application'
module Lib
  class Application < AbstractApplication

    def self.instance
      @instance ||= Rack::Builder.new do
        run Lib::Application.new
      end.to_app
    end

    post '/articles' do |env|
      [201, {'Content-Type' => 'text/plain'}, ['Posted']]
    end

    get '/articles/:id' do |env|
      puts env.params
      puts env.req
      [200, {'Content-Type' => 'text/plain'}, ['Hello']]
    end

    get '/404' do |env|
      [404, {'Content-Type' => 'text/plain'}, ['Hello']]
    end

    def proc(env)
      @request = Rack::Request.new(env)
      Application.find_action @request
    end

    on_call
  end
end
