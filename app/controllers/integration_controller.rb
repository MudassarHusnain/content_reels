class IntegrationController < ApplicationController
  require 'httparty'
  APP_ID = '1648832315584398'
  APP_SECRET = '8b515be9d65b7c36fe310e5a17dc697f'

  def index
  end
  def create
    login_url = "https://www.facebook.com/v2.3/dialog/oauth?client_id=#{APP_ID}&redirect_uri=http://localhost:3000/auth/facebook/callback&scope=email"
    redirect_to login_url, allow_other_host: true
    byebug
    puts response.body
  end

  def facebook_callback

    code = params[:code]
    token_url = "https://graph.facebook.com/v16.0/oauth/access_token"
    response = HTTParty.get(token_url, query: {
      client_id: APP_ID,
      redirect_uri: "http://localhost:3000/auth/facebook/callback",
      client_secret: APP_SECRET,
      code: code
    })
    access_token = response["access_token"]
    response = HTTParty.get('https://graph.facebook.com/v2.3/me', {
      query: {
        access_token: access_token,
        fields: 'name,email',
        locale: 'en_US',
        method: 'get',
        pretty: 0,
        # sdk: 'joey',
        suppress_http_code: 1
      }
    })
    puts response.body

    access_token = access_token
    byebug
    url = "https://graph.facebook.com/v16.0/me/groups?access_token=#{access_token}"
    response = HTTParty.get(url)
    @posts = JSON.parse(response.body)['data']
  end
end