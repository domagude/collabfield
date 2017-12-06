require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "index", :type => :request do

  context 'non-signed in user' do
    it 'redirect to root_path' do
      get '/messenger'
      expect(response).to redirect_to(root_path)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'renders an index template' do
      get '/messenger'
      expect(response).to render_template(:index)
    end
  end

end