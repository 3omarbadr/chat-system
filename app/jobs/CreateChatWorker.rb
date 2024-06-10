class CreateChatWorker
  include Sidekiq::Worker

  def perform(application_token)
    Rails.logger.info "CreateChatWorker started for application token: #{application_token}"
    application = Application.find_by(token: application_token)
    if application
      last_chat = application.chats.order(:number).last
      chat_number = last_chat ? last_chat.number + 1 : 1
      application.chats.create!(number: chat_number)
      Rails.logger.info "Chat created with number #{chat_number} for application #{application_token}"
    else
      Rails.logger.warn "Application not found for token: #{application_token}"
    end
  end
end
