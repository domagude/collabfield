class PostsForBranchService
  def initialize(params)
    @search = params[:search]
    @category = params[:category]
    @branch = params[:branch]
  end

  # get posts depending on the request
  def call
    if @category.blank? && @search.blank?
      posts = Post.by_branch(@branch).all
    elsif @category.blank? && @search.present?
      posts = Post.by_branch(@branch).search(@search)
    elsif @category.present? && @search.blank?
      posts = Post.by_category(@branch, @category)
    elsif @category.present? && @search.present?
      posts = Post.by_category(@branch, @category).search(@search)
    else
    end
  end

end