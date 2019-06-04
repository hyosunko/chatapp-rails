class ChatroomsController < ApplicationController
  def index
    session[:chatrooms] ||= []

    @users = User.all.where.not(id: current_user)
    @chatrooms = Chatroom.includes(:recipient, :messages).find(session[:chatrooms])
  end
end
