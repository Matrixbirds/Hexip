require_relative 'router'
require_relative 'abstract_application'
module Lib
  class Application < AbstractApplication
    routes '/articles/:id' do |env|
      puts env.params
      puts env.req
      [200, {'Content-Type' => 'text/plain'}, ['Hello']]
    end
    routes '/404' do |env|
      [404, {'Content-Type' => 'text/plain'}, ['Hello']]
    end

    def proc(env)
      @request = Rack::Request.new(env)
      Application.find_action @request
    end

    on_call
  end
end
