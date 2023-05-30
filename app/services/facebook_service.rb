class FacebookService
  include Integration
  APP_ID = Rails.application.credentials[:facebook][:app_id]
  APP_SECRET = Rails.application.credentials[:facebook][:app_secret]
  URL = Rails.application.credentials[:host]
  def initialize(*args)
    @id = args.first[:id] if args.first[:id]
    @access_token = args.first[:token] if args.first[:token]
  end


  def facebook_call(token)
    access_token = token
    groups_list = "https://graph.facebook.com/v16.0/me/groups?access_token=#{access_token}"
    pages_list = "https://graph.facebook.com/v16.0/me/accounts?access_token=#{access_token}"
    groups_response = HTTParty.get(groups_list)
    pages_response = HTTParty.get(pages_list)
    facebook_api_data(groups_response,pages_response)

  end

  def publish_video_on_group
    selected_value = @id.split(',')
    group_id = selected_value[0]
    user_access_token = @access_token
    endpoint = "https://graph.facebook.com/v16.0/#{group_id}/videos"
    video_url = 'https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/footage/skater.hd.mp4'
    response = HTTParty.post(endpoint,
                             query: {
                               access_token: user_access_token,
                               file_url: video_url,
                               title: "New Delayed Job Test Video",
                               description: "This is New Delayed Job Test VIDEO FOR TESTING"
                             }
    )
    video_id = response["id"]
    endpoint = "https://graph.facebook.com/#{video_id}"
    query_params = { access_token: user_access_token }
    HTTParty.get(endpoint, query: query_params)

  end

  def publish_video_on_page
    selected_value = @id.split(',')
    page_id = selected_value[0]
    user_access_token = @access_token
    response = HTTParty.get(
      "https://graph.facebook.com/v16.0/me/accounts",
      query: { access_token: user_access_token }
    )

    data = response.parsed_response['data']
    page = data.find { |page| page['id'] == page_id }
    page_access_token = page['access_token']
    p_access_token = page_access_token
    video_url = 'https://cdn.shotstack.io/au/stage/5om1wwit30/e0a3ed51-4fc6-42f8-8f08-1b284288d04c.mp4?_ga=2.74237458.1604961035.1684158384-1191760858.1682681772&_gl=1*1n9it0t*_ga*MTE5MTc2MDg1OC4xNjgyNjgxNzcy*_ga_0KPVTRT370*MTY4NDQwNDAzMy4yMS4xLjE2ODQ0MTA0NjEuMC4wLjA'
    url = "https://graph.facebook.com/v16.0/#{page_id}/videos"
    query_params = {
      title: "New Delayed Job Test Video",
      description: "This is New Delayed Job Test VIDEO FOR TESTING",
      access_token: p_access_token,
      file_url: video_url
    }

    HTTParty.post(url, query: query_params)
  end

end
