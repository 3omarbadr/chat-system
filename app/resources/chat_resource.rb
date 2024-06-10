class ChatResource < BaseResource
  private

  def serialize(chat)
    {
      chat_number: chat.number,
      messages_count: chat.messages_count,
      messages: chat.messages.map { |message| MessageResource.new(message).as_json }
    }
  end
end

