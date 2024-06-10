class MessageResource < BaseResource
  private

  def serialize(message)
    {
      message_number: message.number,
      message_body: message.body
    }
  end
end
