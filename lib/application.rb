require_relative 'router'
require_relative 'abstract_application'
module Lib
  class Application < AbstractApplication

    def self.instance
      @instance ||= Rack::Builder.new do
        run Lib::Application.new
      end.to_app
    end

    get '/articles', &ArticlesApi.instance.method(:index)
    get '/articles/:id', &ArticlesApi.instance.method(:show)
    get '/login', &LoginApi.instance.method(:login)
    get '/callback/:code', &LoginApi.instance.method(:callback)

    get '/404', &proc {|ctx, params = ctx.req.params|
      [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
    }

    def proc(env)
      @request = Rack::Request.new(env)
      Application.find_action @request
    rescue ActiveRecord::RecordNotFound => not_found
      [404, {'Content-Type' => 'application/json'}, ["#{not_found}"]]
    rescue => err
      [500, {'Content-Type' => 'application/json'}, ["#{err}"]]
    end

    on_call
  end
end
