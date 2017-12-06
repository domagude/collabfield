require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  context '#private_conversations_windows' do
    let(:conversations) { conversations = create_list(:private_conversation, 2) }
    
    it 'returns private conversations' do
      assign(:private_conversations_windows, conversations)
      controller.params[:controller] = 'not_messengers'
      expect(helper.private_conversations_windows).to eq conversations
    end

    it 'returns an empty array' do
      assign(:private_conversations_windows, conversations)
      controller.params[:controller] = 'messengers'
      expect(helper.private_conversations_windows).to eq []
    end
  end

  context '#group_conversations_windows' do
    let(:conversations) { create_list(:group_conversation, 2) }

    it 'returns group conversations' do
      assign(:group_conversations_windows, conversations)
      controller.params[:controller] = 'not_messengers'
      expect(helper.group_conversations_windows).to eq conversations
    end

    it 'returns an empty array' do
      assign(:group_conversations_windows, conversations)
      controller.params[:controller] = 'messengers'
      expect(helper.group_conversations_windows).to eq []
    end
  end
end