class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.includes(:recipient).find(params[:chatroom_id])
    @message = @chatroom.messages.create(message_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end
end
