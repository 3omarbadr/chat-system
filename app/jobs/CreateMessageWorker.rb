class CreateMessageWorker
  include Sidekiq::Worker

  def perform(chat_id, message_body)
    Rails.logger.info "CreateMessageWorker started for chat ID: #{chat_id}"

    chat = Chat.find_by(id: chat_id)

    if chat
      last_message = chat.messages.order(:number).last
      message_number = last_message ? last_message.number + 1 : 1

      message = chat.messages.create!(number: message_number, body: message_body)
      Rails.logger.info "Message created with number #{message_number} for chat ID #{chat_id}"

      # Update the messages_count for the chat
      chat.increment!(:messages_count)
    else
      Rails.logger.warn "Chat not found for ID: #{chat_id}"
    end
  rescue StandardError => e
    Rails.logger.error "Failed to create message for chat ID #{chat_id}: #{e.message}"
  end
end
