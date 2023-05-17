require "net/http"

class ShotstackService
  def initialize(api_key)
    @api_key = api_key
  end

  def create_render(edit)
    uri = URI("https://api.shotstack.io/render")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{@api_key}"
    request.body = edit.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end
end
