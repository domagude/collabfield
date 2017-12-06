class Group::ConversationsController < ApplicationController

  def create
    @conversation = create_group_conversation
    add_to_conversations unless already_added?

    respond_to do |format|
      format.js
    end
  end

  def update
    Group::AddUserToConversationService.new({
      conversation_id: params[:id],
      new_user_id: params[:user][:id],
      added_by_id: params[:added_by]
    }).call
  end

  def open
    @conversation = Group::Conversation.find(params[:id])
    add_to_conversations unless already_added?
    respond_to do |format|
      format.js { render partial: 'group/conversations/open' }
    end
  end

  def close
    @conversation = Group::Conversation.find(params[:id])

    session[:group_conversations].delete(@conversation.id)
 
    respond_to do |format|
      format.js
    end
  end
  
  private

  def add_to_conversations
    session[:group_conversations] ||= []
    session[:group_conversations] << @conversation.id
  end
 
  def already_added?
    session[:group_conversations].include?(@conversation.id)
  end

  def create_group_conversation
    Group::NewConversationService.new({
      creator_id: params[:creator_id],
      private_conversation_id: params[:private_conversation_id],
      new_user_id: params[:group_conversation][:id]
    }).call
  end

end
