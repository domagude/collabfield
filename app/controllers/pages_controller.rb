class PagesController < ApplicationController

  def index
    @hobby_posts = Post.by_branch('hobby').limit(8)
    @study_posts = Post.by_branch('study').limit(8)
    @team_posts = Post.by_branch('team').limit(8)
    @contacts = user_signed_in? ? current_user.all_active_contacts : ''
  end

end
