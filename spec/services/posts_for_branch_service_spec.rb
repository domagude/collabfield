require 'rails_helper'
require './app/services/posts_for_branch_service.rb'

describe PostsForBranchService do

  context '#call' do
    let(:not_included_posts) { create_list(:post, 2) }
    let(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:post) do
      create(:post,
              title: 'a very fun post', 
              category_id: category.id)
    end
    it 'returns posts filtered by a branch' do
      not_included_posts
      category
      included_posts = create_list(:post, 2, category_id: category.id)
      expect(PostsForBranchService.new({branch: 'hobby'}).call).to(
        match_array included_posts
      )
    end

    it 'returns posts filtered by a branch and a search input' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({branch: 'hobby', search: 'fun'}).call).to(
        eq included_post
      )
    end

    it 'returns posts filtered by a category name' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({branch: 'hobby', category: 'arts'}).call).to(
        eq included_post
      )
    end

    it 'returns posts filtered by a category name and a search input' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({name: 'arts', 
                                        search: 'fun', 
                                        branch: 'hobby'}).call).to eq included_post
    end
  end
end