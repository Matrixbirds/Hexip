class LoginApi

  def app
    Lib::Application
  end

  def self.instance
    @instance ||= new
  end

  def login(_ctx, params=_ctx.req.params)
    oauth_uri = 'https://github.com/login/oauth/authorize?'
    {
      client_id: app.client_id,
      redirect_uri: URI::encode('http://localhost:3000/callback'),
      scope: 'user',
      allow_signup: true,
      state: nil
    }.each do |k, v|
      oauth_uri += "#{k}=#{v}&"
    end
    [302, {'Location' => oauth_uri}, []]
  end

  def callback(_ctx, params=_ctx.req.params)
    session_code = params&.dig('code')
    result = RestClient.post('https://github.com/login/oauth/access_token',
                              {client_id: app.client_id,
                              client_secret: app.secrets_key,
                              code: session_code},
                              {accept: :json})
    access_token = JSON.parse(result)['access_token']
    user_info = JSON.parse(RestClient.get('https://api.github.com/user',
                                        {params: {access_token: access_token},
                                        accept: :json}))
    puts user_info
    [302, {'Location' => '/'}, []]
  end
end
