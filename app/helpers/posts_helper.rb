module PostsHelper

  def create_new_post_partial_path
    if user_signed_in?
      'posts/branch/create_new_post/signed_in'
    else
      'posts/branch/create_new_post/not_signed_in'
    end
  end

  def all_categories_button_partial_path
    if params[:category].blank?
      'posts/branch/categories/all_selected'
    else
      'posts/branch/categories/all_not_selected'
    end
  end

  def no_posts_partial_path(posts)
    posts.empty? ? 'posts/shared/no_posts' : 'shared/empty_partial'
  end

  def post_format_partial_path
    current_page?(root_path) ? 'posts/post/home_page' : 'posts/post/branch_page'
  end

  def category_field_partial_path
    if params[:category].present?
      'posts/branch/search_form/category_field'
    else
      'shared/empty_partial'
    end
  end

  def update_pagination_partial_path
    if @posts.next_page
      'posts/posts_pagination_page/update_pagination'
    else
      'posts/posts_pagination_page/remove_pagination'
    end
  end

  def contact_user_partial_path
    if user_signed_in?
      @post.user.id != current_user.id ? 'posts/show/contact_user' : 'shared/empty_partial'
    else 
      'posts/show/login_required'
    end
  end

  def leave_message_partial_path
    if @message_has_been_sent
      'posts/show/contact_user/already_in_touch'
    else
      'posts/show/contact_user/message_form'
    end
  end
  
end
