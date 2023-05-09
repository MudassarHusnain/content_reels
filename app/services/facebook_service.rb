class FacebookService
  def initialize(token)
    @graph = Koala::Facebook::API.new(token)
  end

  def get_profile_data
    @graph.get_object('me')
  end
end
