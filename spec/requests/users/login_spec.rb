require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "login", :type => :request do

  context 'non-signed in user' do
    it 'renders a new template' do
      get '/login'
      expect(response).to render_template(:new)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'redirects to root_path' do
      get '/login'
      expect(response).to redirect_to(root_path)
    end
  end
end