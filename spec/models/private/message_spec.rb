require 'rails_helper'

RSpec.describe Private::Message, type: :model do

  let(:message) { build(:private_message) }

  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs_to conversation' do
      association = described_class.reflect_on_association(:conversation)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'Private::Conversation'
      expect(association.options[:foreign_key]).to eq :conversation_id
    end
  end

  context 'Validations' do
    it "is valid to create a new message" do
      expect(message).to be_valid
    end

    it "is not valid without a body" do
      message.body = nil
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
    it 'gets a previous message' do
      conversation = create(:private_conversation)
      message1 = create(:private_message, conversation_id: conversation.id)
      message2 = create(:private_message, conversation_id: conversation.id)
      expect(message2.previous_message).to eq message1
    end
  end
end
