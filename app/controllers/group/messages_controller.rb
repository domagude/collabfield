class Group::MessagesController < ApplicationController
  include Messages
  
  def index
    get_messages('group', 15)
    @user = current_user
    @is_messenger = params[:is_messenger]
    respond_to do |format|
      format.js { render partial: 'group/messages/load_more_messages' }
    end
  end
end
