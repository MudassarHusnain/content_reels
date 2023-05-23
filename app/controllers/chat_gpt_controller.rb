  class ChatGptController < ApplicationController
    URL = Rails.application.credentials[:chatgpt_token]
    def converse

    end

    def send_to_chat
      user_input = params[:text]

      url = 'https://api.openai.com/v1/chat/completions'
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer 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"
      }
      body= {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: user_input }]
      }
      response = HTTParty.post(url, body: body.to_json, headers: headers)
      response.parsed_response

    end

    def extract_generated_text(response)

    end
  end

