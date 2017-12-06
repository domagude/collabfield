module Group::MessagesHelper
  require 'shared/messages_helper'
  include Shared::MessagesHelper

  def replace_link_to_group_messages_partial_path
    'group/messages/load_more_messages/window/replace_link_to_messages'   
  end 

  def group_message_date_check_partial_path(new_message, previous_message)
    # if a previous message exists
    if defined?(previous_message) && previous_message.present?
      # if the date is different between the previous and new messages
      if previous_message.created_at.to_date != new_message.created_at.to_date
        'group/messages/message/new_date'
      else
        'shared/empty_partial'
      end
    else
      'shared/empty_partial'
    end
  end

  def group_message_seen_by(message)
    seen_by_names = []
    # If anyone has seen the message
    if message.seen_by.present?
      message.seen_by.each do |user_id|
        seen_by_names << User.find(user_id).name
      end
    end
    seen_by_names
  end

  def seen_by_user?
    @seen_by_user ? '' : 'unseen'
  end

  def message_content_partial_path(user, message, previous_message)
    # if previous message exists
    if defined?(previous_message) && previous_message.present?
      # if new message is created by the same user as previous'
      if previous_message.user_id == user.id
        'group/messages/message/same_user_content'
      else
        'group/messages/message/different_user_content'
      end
    else
      'group/messages/message/different_user_content'
    end
  end
end
