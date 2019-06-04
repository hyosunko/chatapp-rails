class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.user
    recipient = message.chatroom.opposed_user(sender)

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end

  private

  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "chatrooms-#{user.id}",
      message: render_message(message, user),
      chatroom_id: message.chatroom_id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "chatrooms-#{user.id}",
      message: render_message(message, user),
      chatroom_id: message.chatroom_id
    )
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end
end
