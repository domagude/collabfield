module NavigationHelper

  # return a conversation header partial's path
  def conversation_header_partial_path(conversation)
    if conversation.class == Private::Conversation
      'layouts/navigation/header/dropdowns/conversations/private'
    else
      'layouts/navigation/header/dropdowns/conversations/group'
    end  
  end

  def collapsible_links_partial_path
    if user_signed_in?
      'layouts/navigation/collapsible_elements/signed_in_links'
    else
      'layouts/navigation/collapsible_elements/non_signed_in_links'
    end
  end

  # render the navigation header's content
  def nav_header_content_partials
    partials = []
    if params[:controller] == 'messengers' 
      partials << 'layouts/navigation/header/messenger_header'
    else # controller is not messengers  
      partials << 'layouts/navigation/header/toggle_button'
      partials << 'layouts/navigation/header/home_button'
      partials << 'layouts/navigation/header/dropdowns' if user_signed_in?
    end
    partials
  end

  def nav_contact_requests_partial_path
    # if contact requests exist
    if current_user.pending_received_contact_requests.present? 
      'layouts/navigation/header/dropdowns/contact_requests/requests' 
    else # contact requests do not exist 
      'layouts/navigation/header/dropdowns/contact_requests/no_requests'
    end
  end

end