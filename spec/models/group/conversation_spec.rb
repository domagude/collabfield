require 'rails_helper'

RSpec.describe Group::Conversation, type: :model do

  let(:conversation) { build(:group_conversation) }

  context 'Associations' do
    it 'has_and_belongs_to_many users' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_and_belongs_to_many
    end

    it 'has_many messages' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'Group::Message'
      expect(association.options[:foreign_key]).to eq 'conversation_id'
      expect(association.options[:dependent]).to eq :destroy
    end
  end

end
