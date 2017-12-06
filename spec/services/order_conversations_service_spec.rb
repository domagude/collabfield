require 'rails_helper'
require './app/services/order_conversations_service.rb'

describe OrderConversationsService do
  context '#call' do
    it 'returns ordered conversations in descending order' do
      user = create(:user)
      conversation1 = create(:private_conversation,
                              sender_id: user.id,
                              messages: [create(:private_message)])
      conversation2 = create(:group_conversation,
                              users: [user],
                              messages: [create(:group_message)])
      conversation3 = create(:private_conversation,
                              sender_id: user.id,
                              messages: [create(:private_message)])
      conversations = [conversation3, conversation2, conversation1]
      expect(OrderConversationsService.new({user: user}).call).to eq conversations
    end
  end
end