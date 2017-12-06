require 'rails_helper'

RSpec.describe PagesHelper, :type => :helper do
  context '#contacts_list_partial_path' do
    it "returns contacts partial path" do
      view.stub("user_signed_in?").and_return(true)
      expect(helper.contacts_list_partial_path).to eq 'pages/index/contacts' 
    end

    it "returns login_required partial path" do
      view.stub("user_signed_in?").and_return(false)
      expect(helper.contacts_list_partial_path).to eq 'pages/index/login_required'
    end
  end

  context '#login_required_links_partial_path' do
    it 'return login_required_links partial path' do
      view.stub("user_signed_in?").and_return(true)
      expect(helper.login_required_links_partial_path).to eq(
        'pages/index/side_menu/login_required_links'
      )
    end

    it 'return an empty partial path' do
      view.stub("user_signed_in?").and_return(false)
      expect(helper.login_required_links_partial_path).to eq 'shared/empty_partial'
    end
  end

  context '#no_contacts_partial_path' do
    it 'returns no_contacts partial path' do
      assign(:contacts, [])
      expect(helper.no_contacts_partial_path).to eq(
        'pages/index/contacts/no_contacts' 
      )
    end

    it 'return an empty partial path' do
      assign(:contacts, create_list(:contact, 2))
      expect(helper.no_contacts_partial_path).to eq 'shared/empty_partial'
    end
  end

  context '#no_posts_partial_path' do
    it 'returns no_posts partial path' do
      posts = []
      expect(helper.no_posts_partial_path(posts)).to eq(
        'pages/index/main_content/no_posts'
      )
    end

    it 'returns an empty partial path' do
      posts = create_list(:post, 2)
      expect(helper.no_posts_partial_path(posts)).to eq 'shared/empty_partial'
    end
  end
end