module PagesHelper

	def contacts_list_partial_path
		user_signed_in? ? 'pages/index/contacts' : 'pages/index/login_required'
	end

  def login_required_links_partial_path
    if user_signed_in? 
      'pages/index/side_menu/login_required_links' 
    else 
      'shared/empty_partial'
    end
  end

  def no_contacts_partial_path
    @contacts.empty? ? 'pages/index/contacts/no_contacts' : 'shared/empty_partial'
  end

  def no_posts_partial_path(posts)
    posts.empty? ? 'pages/index/main_content/no_posts' : 'shared/empty_partial'
  end

end
