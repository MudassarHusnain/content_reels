  class ChatGptController < ApplicationController
    def send_to_chat
      image = ChatgptService.new
      image.image_generation
    end
  end

