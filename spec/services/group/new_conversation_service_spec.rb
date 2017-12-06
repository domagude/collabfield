require 'rails_helper'
require './app/services/group/new_conversation_service.rb'

describe Group::NewConversationService do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:new_user) { create(:user) }
  let(:private_conversation) { create(:private_conversation,
                                       sender_id: user1.id,
                                       recipient_id: user2.id) }
  context '#call' do
    it 'returns a new created group conversation' do
      new_conversation = Group::NewConversationService.new({
                           creator_id: user1.id,
                           private_conversation_id: private_conversation.id,
                           new_user_id: new_user.id
                         }).call
      last_conversation = Group::Conversation.last
      expect(new_conversation).to eq last_conversation
      expect(last_conversation.messages.count).to eq 1
    end
  end
end