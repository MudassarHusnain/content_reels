  class ChatGptController < ApplicationController
    def new
    end
    def send_to_chat
      image = ChatgptService.new
      image.image_generation

      # user_input = params[:text]
      # client = OpenAI::Client.new
      # response = client.chat(
      #   parameters: {
      #     model: "gpt-3.5-turbo", # Required.
      #     messages: [{ role: "user", content: user_input}], # Required.
      #     temperature: 0.7,
      #   })
      # @data =  response.dig("choices", 0, "message", "content")

    end

    def extract_generated_text(response)
    end
  end

