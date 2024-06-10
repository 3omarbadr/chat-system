class ChatsController < ApplicationController
  before_action :set_application
   before_action :set_chat, only: [:show, :update]

   def index
       @chats = @application.chats
       render json: ChatResource.new(@chats).as_json
   end

  def create
    @chat = @application.chats.new
    @chat.number = @application.chats.count + 1
    if @chat.save
      render json: ChatResource.new(@chat).as_json, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: ChatResource.new(@chat).as_json
  end

  private

   def set_application
     @application = Application.find_by(token: params[:application_token])
     render json: { error: 'Application not found' }, status: :not_found unless @application
   end

    def set_chat
       @chat = @application.chats.find_by(number: params[:number])
       unless @chat
         render json: { error: 'Chat not found' }, status: :not_found
       end
    end

   def chat_params
     params.require(:chat).permit(:number)
   end
end
