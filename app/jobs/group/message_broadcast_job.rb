class Group::MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, previous_message, current_user)
    # if the message's attribute added_new_users has present values
    # broadcast a notification to those users that they were added to a group conv
    if message.added_new_users.present?
      conversation = message.conversation
      message.added_new_users.each do |user_id|
        ActionCable.server.broadcast(
          "notifications_#{user_id}",
          notification: 'added-to-group-conversation',
          conversation_id: conversation.id,
          message_author: message.user_id,
          link_to_conversation: render_link_to_conversation(conversation, 
                                                            user_id,
                                                            current_user)
        )
      end
    else
      # broadcast message to all conversation's participants
      conversation_id = message.conversation_id
      ActionCable.server.broadcast(
        "group_conversation_#{conversation_id}",
        message: render_message(message, previous_message),
        conversation_id: conversation_id,
        user_id: message.user_id
      )
    end
  end

  def render_message(message, previous_message)
    ApplicationController.render(
      partial: 'group/messages/message',
      locals: { message: message, 
                previous_message: previous_message, 
                user: message.user }
    )
  end

  def render_link_to_conversation(conversation, user_id, current_user)
    ApplicationController.render(
      partial: 'layouts/navigation/header/dropdowns/conversations/group',
      locals: { conversation: conversation, 
                user_id: user_id, 
                current_user: current_user }
    )
  end


end





