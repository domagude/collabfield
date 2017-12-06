require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "show", :type => :request do

  shared_examples 'render_show_template' do
    let(:post) { create(:post) }
    it 'renders a show template' do
      get post_path(post)
      expect(response).to render_template(:show)
    end
  end

  context 'non-signed in user' do
    it_behaves_like 'render_show_template'
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it_behaves_like 'render_show_template'
  end

end