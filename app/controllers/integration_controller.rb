class IntegrationController < ApplicationController
  require 'httparty'
  APP_ID = '1295326561066235'
  # APP_ID = '581414277415548'
  # APP_SECRET = '3729e18af2fd1f6740a474651a0434a7'
  APP_SECRET = '579664d4eac2617e0429da4ea9b0dfca'
  # curl -i -X GET "https://graph.facebook.com/debug_token?input_token=AQB8gY9tKhnsDkzpBdKBwc9FL0drX1WMKNdp4Q8u88qYTtrNc4PXXMpFh4CEMUgL5VrlEWmZlOUw9-HXdc7_GM9ZKfqAZ5KAA98_InVLVaRj72eohv1BwGMOMtyLpO40YNOjwe3odXOuM5WE8lkFIhvATCoR9j1iJVCcWXRrSuIhfdqx_5TgHoh2ppWmEgaNMTAOWqUFA50Z_17apMBT4TA2Z7IhM-xNAPMmrOH49uCam3v16vGvOmtHUd0FjDcCltme6mFIpU20DiI3sgMjJqjg_E2OXiKgs3Aw1DK7KygY8xLZtWfEV92lNBYC8K4vgOUr6PTJ4QVyAc9nY-kH32AcrizvVLf0EOnkeX5-89azrGpwrVGnoEk3fjTm9PCfWc8&access_token=EAANlyZCZCgMJsBAPZAVezZCA5y1Gz5ZBZBf9nes3PDOChq6mxS0pO32KZB2WBcooEXjPZAIYYJ7Wf4fAe75bMBsX1u50uplZBSoDF8uJuZBd7pf2BZCEqoWO9JE580yYMvjbywIFS4dZAPFOEb4mxhIPGRmc2gnlPZAvWuZAoKJuRioNnaj8bE3azzRwxZBikCbu7Ha9yQEShJU84votU6jszNfpOVehTjMBZBXoZC8slEloZAA2UR6EmbDX7VaZB6M"
  # curl -i -X GET "https://graph.facebook.com/me/accounts?type=page&access_token=EAALFmNPM8dABAEZAS9aUGlVM6NhnaAdcFiR7A1tI8xHwrM62FBvrpsJ31Ogy0nlHVplISvOgzZCR8THyhbSHDsZBOsk7ponH53zDrc9W5wsZAtQUTmbq1Okmc1FiZBeWvjd69wsAd452ZBku6ZAZAY7FKS1jmZBUFLxPwlEolvSq4qbtQd8HS7EfeMKl4WDnzwWph9yIPPv0A5d9E3c7FLUOZB"
  # curl -i -X GET "https://graph.facebook.com/v2.3/me?access_token=EAANlyZCZCgMJsBANYCq2iAemoerQSPNZBQajbwSuqsZAYMVpb3RkASDEV8WropCLorEA9KuJI5F0KEX8yqSZC7rpQUqrYjmuMeoxtxlTptLVtminjcZCchIGkbeCML5M6T8EvPZB6LM7WZCFBbBPoXSPN6RH2njkYLEE6HlM4L10YxN5cbah2QWhG1OLplMey1ZAZCku52DA3qjzZAj9Ae15QEgGbP3YsWhtgNWhWkzoRjV3eTsC5TvNtF1"
  # curl -i -X GET "https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=1295326561066235&client_secret=579664d4eac2617e0429da4ea9b0dfca&fb_exchange_token=579664d4eac2617e0429da4ea9b0dfca"
  def index
  end
  def create
    login_url = "https://www.facebook.com/v2.3/dialog/oauth?client_id=1295326561066235&redirect_uri=http://localhost:3000/auth/facebook/callback&scope=email"
    redirect_to login_url, allow_other_host: true
    puts response.body
  end

  # Set the Facebook app ID and secret


  # After the user logs in and grants permission, Facebook will redirect the user back to your application's callback URL
  # In your Rails controller, you can handle the callback like this:

  def facebook_callback
    code = params[:code]
    # code = code_id
    # client_id = APP_ID
    # client_secret = APP_SECRET
    # redirect_uri = "http://localhost:3000/auth/facebook/callback"
    #
    # token_url = "https://graph.facebook.com/v2.3/oauth/access_token?client_id=#{client_id}&redirect_uri=#{redirect_uri}&client_secret=#{client_secret}&code=#{code}"
    # response = HTTParty.get(token_url)
    #
    # if response.code == 200
    #   access_token = response.parsed_response['access_token']
    #   # Access token is valid, do something with it
    # else
    #   error_message = response.parsed_response['error']['message']
    #   # Code is invalid, handle the error
    # end


    # https://graph.facebook.com/v16.0/oauth/access_token?
    # client_id={app-id}
    # &redirect_uri={redirect-uri}
    # &client_secret={app-secret}
    # &code={code-parameter}

    token_url = "https://graph.facebook.com/v16.0/oauth/access_token"
    response = HTTParty.get(token_url, query: {
      client_id: '1295326561066235',
      redirect_uri: "http://localhost:3000/auth/facebook/callback",
      client_secret: '579664d4eac2617e0429da4ea9b0dfca',
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
        sdk: 'joey',
        suppress_http_code: 1
      }
    })
    puts response.body

    group_id = "617862747041464"
    access_token = access_token

    url = "https://graph.facebook.com/v16.0/me/groups?access_token=#{access_token}"
    response = HTTParty.get(url)
      posts = JSON.parse(response.body)['data']
    puts posts
  end
end

# curl -i -X GET "https://graph.facebook.com/{617862747041464}/feed?limit=5&amp;access_token=EAANlyZCZCgMJsBANdPZBvnO8JAu73vQbiX6Y1EbzhaiGLauqmRNGDppn7RCGST1PxsqVJb2tNAVWYKlTdjoZBtGdCO7iw0tGxp7GF9oZBPHgR1rJvSVlPytCpGmfqHNH3xvWhVyCo0eku8rhUIKmQBBrZAGF8YvEwIG2v4ZC2y5TdZA0Pqi2oCOPokHWyuSZBkFib5q5K1CZCXYU7qjLAWLGSuG1hpASTFMPxeR8IvBZC2kZA8HlnRgHJJAg"
