require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "edit", :type => :request do

  context 'non-signed in user' do
    it 'redirects to a sign_in path' do
      get '/users/edit'
      expect(response).to redirect_to('/users/sign_in')
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'renders an edit template' do
      get '/users/edit'
      expect(response).to render_template(:edit)
    end
  end
end