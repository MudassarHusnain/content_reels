class ChatgptService
  def send_data
    user_input = params[:text]
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: user_input}], # Required.
        temperature: 0.7,
      })
    data =  response.dig("choices", 0, "message", "content")

  end

  def image_generation
    client = OpenAI::Client.new
    response = client.images.generate(parameters: { prompt: "Real estate business", size: "256x256" })
    puts response.dig("data", 0, "url")

  end

end