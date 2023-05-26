module Integration
  extend ActiveSupport::Concern
  def facebook_api_data(groups_response,pages_response)

    (groups_response["data"] + pages_response["data"]).each_with_object([]) do |api_data, modified_array|
      if groups_response["data"].include?(api_data)
        api_data['type'] = 'GROUPS'
      elsif pages_response["data"].include?(api_data)
        api_data['type'] = 'PAGES'
      end
      modified_array << api_data
    end
  end

  def check_session
    current_user.facebook_token.present?
  end

  def connected
    @status = "connected"
  end

  def disconnected
    @status = "disconnected"
  end
end
