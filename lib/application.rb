require_relative 'router'
require_relative 'abstract_application'
module Lib
  class Application < AbstractApplication

    def self.instance
      @instance ||= Rack::Builder.new do
        run Lib::Application.new
      end.to_app
    end

    get '/login' do |ctx|
      oauth_uri = 'https://github.com/login/oauth/authorize?'
      {
        client_id: client_id,
        redirect_uri: URI::encode('http://localhost:3000/callback'),
        scope: 'user',
        allow_signup: true,
        state: nil
      }.each do |k, v|
        oauth_uri += "#{k}=#{v}&"
      end
      [302, {'Location' => oauth_uri}, []]
    end

    get '/callback' do |ctx|
      session_code = ctx.req.params&.dig('code')
      result = RestClient.post('https://github.com/login/oauth/access_token',
                               {client_id: client_id,
                                client_secret: secrets_key,
                                code: session_code},
                                {accept: :json})
      access_token = JSON.parse(result)['access_token']
      user_info = JSON.parse(RestClient.get('https://api.github.com/user',
                                          {params: {access_token: access_token},
                                          accept: :json}))
      puts user_info
      [302, {'Location' => '/'}, []]
    end

    get '/articles/:id' do |ctx|
      puts env.params
      puts env.req
      [200, {'Content-Type' => 'text/plain'}, ['Hello']]
    end

    get '/404' do |ctx|
      debugger
      [404, {'Content-Type' => 'text/plain'}, ['Hello']]
    end

    def proc(env)
      @request = Rack::Request.new(env)
      Application.find_action @request
    end

    on_call
  end
end
