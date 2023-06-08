class ChatService
  def initialize(*args)
    @content = args.first[:content] if args.first[:content]
  end

  def chat_data
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "Write a paragraph on the following topic #{@content}  make it precise" }], # Required.
        temperature: 0.7,
      },
    )
    response.dig("choices", 0, "message", "content")
    byebug
  end
end
