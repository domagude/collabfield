require 'rails_helper'

RSpec.describe Group::Message, type: :model do

  let(:message) { build(:group_message) }

  context 'Associations' do
    it 'belongs_to group_conversation' do
      association = described_class.reflect_on_association(:conversation)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'Group::Conversation'
      expect(association.options[:foreign_key]).to eq 'conversation_id'
    end
  end

  context 'Validations' do
    it "is not valid without a content" do 
      message.content = nil
      expect(message).not_to be_valid 
    end

    it "is not valid without a conversation_id" do 
      message.conversation_id = nil
      expect(message).not_to be_valid 
    end

    it "is not valid without a user_id" do 
      message.user_id = nil
      expect(message).not_to be_valid 
    end
  end

  context 'Methods' do
    it 'gets a previous message of a conversation' do
      conversation = create(:group_conversation)
      message1 = create(:group_message, conversation_id: conversation.id)
      message2 = create(:group_message, conversation_id: conversation.id)
      expect(message2.previous_message).to eq message1
    end
  end
 
end
