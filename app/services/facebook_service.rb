class FacebookService
  APP_ID = Rails.application.credentials[:facebook][:app_id]
  APP_SECRET = Rails.application.credentials[:facebook][:app_secret]
  URL = Rails.application.credentials[:host]

  def initialize(*args)
    @code = args.first[:code] if args.first[:code]
    @id = args.first[:id] if args.first[:id]
    @access_token = args.first[:token] if args.first[:token]
  end

  def self.login
    "https://www.facebook.com/v2.3/dialog/oauth?client_id=#{APP_ID}&redirect_uri=#{URL}/auth/facebook/callback&scope=email"
  end

  def facebook_call
    access_token = @access_token
    response = HTTParty.get("https://graph.facebook.com/v2.3/me", {
      query: {
        access_token: access_token,
        fields: "name,email",
        locale: "en_US",
        method: "get",
        pretty: 0,
        suppress_http_code: 1,
      },
    })
    groups_list = "https://graph.facebook.com/v16.0/me/groups?access_token=#{access_token}"
    pages_list = "https://graph.facebook.com/v16.0/me/accounts?access_token=#{access_token}"
    groups_response = HTTParty.get(groups_list)
    pages_response = HTTParty.get(pages_list)
    facebook_response = {}
    facebook_response["groups_data"] = JSON.parse(groups_response.body)["data"]
    facebook_response["pages_data"] = JSON.parse(pages_response.body)["data"]
    facebook_response
  end

  def upload_content
    page_id = @id
    user_access_token = @access_token
    page_url = "https://graph.facebook.com/#{page_id}?fields=access_token&access_token=#{user_access_token}"
    response = HTTParty.get(page_url)
    page_access_token = response["access_token"]
    url = "https://graph.facebook.com/#{page_id}/feed"
    params = {
      query: {
        message: "Testing post on page",
        access_token: page_access_token,
      },
    }
    # Make the POST request using HTTParty
    response = HTTParty.post(url, params)
    puts response
  end

  def get_token
    token_url = "https://graph.facebook.com/v16.0/oauth/access_token"
    response = HTTParty.get(token_url, query: {
                                         client_id: APP_ID,
                                         redirect_uri: "#{URL}/auth/facebook/callback",
                                         client_secret: APP_SECRET,
                                         code: @code,
                                       })
    response["access_token"]
  end
end
