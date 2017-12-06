require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end
  end

  context 'Validations' do
    let(:post) { build(:post) }
    
    it 'creates succesfully' do 
      expect(post).to be_valid
    end

    it 'is not valid without a category' do 
      post.category_id = nil
      expect(post).not_to be_valid
    end

    it 'is not valid without a title' do 
      post.title = nil
      expect(post).not_to be_valid
    end

    it 'is not valid  without a user_id' do
      post.user_id = nil
      expect(post).not_to be_valid
    end

    it 'is not valid  with a title, shorter than 5 characters' do 
      post.title = 'a' * 4
      expect(post).not_to be_valid
    end

    it 'is not valid  with a title, longer than 255 characters' do 
      post.title = 'a' * 260
      expect(post).not_to be_valid
    end

    it 'is not valid without a content' do 
      post.content = nil
      expect(post).not_to be_valid
    end

    it 'is not valid  with a content, shorter than 20 characters' do 
      post.content = 'a' * 10
      expect(post).not_to be_valid
    end

    it 'is not valid  with a content, longer than 1000 characters' do 
      post.content = 'a' * 1050
      expect(post).not_to be_valid
    end
  end  

  context 'Scopes' do
    it 'default_scope orders by descending created_at' do
      first_post = create(:post)
      second_post = create(:post)
      expect(Post.all).to eq [second_post, first_post]
    end

    it 'by_category scope gets posts by particular category' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_category(category.branch, category.name)
      expect(posts.count).to eq 1
      expect(posts[0].category.name).to eq category.name
    end

    it 'by_branch scope gets posts by particular branch' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_branch(category.branch)
      expect(posts.count).to eq 1
      expect(posts[0].category.branch).to eq category.branch
    end

    it 'search finds a matching post' do
      post = create(:post, title: 'awesome title', content: 'great content ' * 5)
      create_list(:post, 10, title: ('a'..'c' * 2).to_a.shuffle.join)
      expect(Post.search('awesome').count).to eq 1
      expect(Post.search('awesome')[0].id).to eq post.id
      expect(Post.search('great').count).to eq 1
      expect(Post.search('great')[0].id).to eq post.id
    end
  end

end
