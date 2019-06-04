class ChatroomsController < ApplicationController
  def index
    session[:chatrooms] ||= []

    @users = User.all.where.not(id: current_user)
    @chatrooms = Chatroom.includes(:recipient, :messages).find(session[:chatrooms])
  end

  def create
    @chatroom = Chatroom.get(current_user.id, params[:user_id])

    add_to_chatrooms unless conversated?

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_chatrooms
    session[:chatrooms] ||= []
    session[:chatrooms] << @chatroom.id
  end

  def conversated?
    session[:chatrooms].include?(@chatroom.id)
  end

end
