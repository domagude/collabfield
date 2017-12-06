require 'rails_helper'

RSpec.describe Group::ConversationsHelper, type: :helper do
  context '#add_people_to_group_conv_list' do
    let(:conversation) { create(:group_conversation) }
    let(:current_user) { create(:user) }
    let(:user) { create(:user) }
    before(:each) do
      create(:contact, 
              user_id: current_user.id, 
              contact_id: user.id,
              accepted: true)
    end

    it 'a user is not included in a list' do
      conversation.users << current_user
      conversation.users << user
      helper.stub(:current_user).and_return(current_user)
      expect(helper.add_people_to_group_conv_list(conversation)).not_to include user
    end

    it 'a user is included in a list' do
      conversation.users << current_user
      helper.stub(:current_user).and_return(current_user)
      expect(helper.add_people_to_group_conv_list(conversation)).to include user
    end
  end

  context '#load_group_messages_partial_path' do
    let(:conversation) { create(:group_conversation) }
    it "returns load_messages partial's path" do
      create_list(:group_message, 2, conversation_id: conversation.id)
      expect(helper.load_group_messages_partial_path(conversation)).to eq(
        'group/conversations/conversation/messages_list/link_to_previous_messages'
      )
    end

    it "returns an empty partial's path" do
      expect(helper.load_group_messages_partial_path(conversation)).to eq(
        'shared/empty_partial'
      )
    end
  end
end
