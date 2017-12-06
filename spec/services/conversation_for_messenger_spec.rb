require 'rails_helper'
require './app/services/conversation_for_messenger_service.rb'

describe ConversationForMessengerService do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:group_conversation) { create(:group_conversation) }
  let(:private_conversation) do 
    create(:private_conversation,
            sender_id: user1.id,
            recipient_id: user2.id)
  end

  context '#call' do
    it 'returns a group conversation' do
      expect(ConversationForMessengerService.new({
        conversation_type: 'group',
        group_conversation_id: group_conversation.id
      }).call).to eq group_conversation
    end

    it 'returns a private conversation' do
      private_conversation
      expect(ConversationForMessengerService.new({
        conversation_type: 'private',
        user1_id: user1.id,
        user2_id: user2.id
      }).call).to eq private_conversation
    end
  end

end