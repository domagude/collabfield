class Private::MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, previous_message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)

    broadcast_to_sender(sender, recipient, message, previous_message)
    broadcast_to_recipient(sender, recipient, message, previous_message)
  end

  private

  def broadcast_to_sender(sender, recipient, message, previous_message)
    ActionCable.server.broadcast(
      "private_conversations_#{sender.id}",
      message: render_message(message, previous_message, sender),
      conversation_id: message.conversation_id,
      recipient_info: recipient
    )
  end

  def broadcast_to_recipient(sender, recipient, message, previous_message)
    ActionCable.server.broadcast(
      "private_conversations_#{recipient.id}",
      recipient: true,
      sender_info: sender,
      message: render_message(message, previous_message, recipient),
      conversation_id: message.conversation_id
    )
  end

  def render_message(message, previous_message, user)
    ApplicationController.render(
      partial: 'private/messages/message',
      locals: { message: message, 
                previous_message: previous_message, 
                user: user }
    )
  end
end
