class ConversationForMessengerService
  def initialize(params)
    @conversation_type = params[:conversation_type]
    @user1_id = params[:user1_id] || nil
    @user2_id = params[:user2_id] || nil
    @group_conversation_id = params[:group_conversation_id] || nil
  end

  def call
    if @conversation_type == 'private'
      Private::Conversation.between_users(@user1_id, @user2_id)[0]
    else
      Group::Conversation.find(@group_conversation_id) 
    end
  end

end