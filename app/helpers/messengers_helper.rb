module MessengersHelper
  def conversations_list_item_partial_path(conversation)
    # if it's a private conversation
    if conversation.class == Private::Conversation
      'messengers/index/conversations_list_item/private'
    else # it is a group conversation
      'messengers/index/conversations_list_item/group'
    end
  end
end
