require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "index", :type => :request do

  shared_examples 'render_index_template' do
    it 'renders an index template' do
      get root_path
      expect(response).to render_template(:index)
    end
  end

  context 'non-signed in user' do
    it_behaves_like 'render_index_template'
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }
    it_behaves_like 'render_index_template'
  end
end