class Group::AddUserToConversationService

  def initialize(params)
    @conversation_id = params[:conversation_id]
    @new_user_id = params[:new_user_id]
    @added_by_id = params[:added_by_id]
  end

  def call
    group_conversation = Group::Conversation.find(@conversation_id)
    new_user = User.find(@new_user_id)
    added_by = User.find(@added_by_id)
    if new_user.group_conversations << group_conversation
      create_info_message(new_user, added_by)
    end
  end

  private

  def create_info_message(new_user, added_by)
    message = Group::Message.new(
      user_id: added_by.id, 
      content: '' + new_user.name + ' added by ' + added_by.name, 
      added_new_users: [new_user.id], 
      conversation_id: @conversation_id)
    if message.save
      Group::MessageBroadcastJob.perform_later(message, nil, nil)
    end
  end

end