class MessagesController < ApplicationController
     before_action :set_application
     before_action :set_chat
     before_action :set_message, only: [:show, :update]

  def index
     @messages = @chat.messages
     render json: MessageResource.new(@messages).as_json
  end

  def create
    @message = @chat.messages.new(message_params)
    @message.number = @chat.messages.count + 1
    #TODO: Use CreateMessageWorker a worker to create the message
    if @message.save
      render json: MessageResource.new(@message).as_json, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def update
    @message = @chat.messages.find_by(number: params[:id])
    if @message.update(message_params)
      render json: MessageResource.new(@message).as_json
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

   def search
       @messages = Message.search(params[:q]).where(chat: @chat)
       render json: @messages.map { |message| MessageResource.new(message).as_json }
     end

  private

    def set_application
      @application = Application.find_by(token: params[:application_token])
      unless @application
        render json: { error: 'Application not found' }, status: :not_found
      end
    end

    def set_chat
         @chat = @application.chats.find_by(number: params[:chat_number])
         unless @chat
           render json: { error: 'Chat not found' }, status: :not_found
         end
     end

  def set_message
      @message = @chat.messages.find_by(number: params[:id])
      unless @message
        render json: { error: 'Message not found' }, status: :not_found
      end
    end

  def message_params
    params.require(:message).permit(:body)
  end
end
