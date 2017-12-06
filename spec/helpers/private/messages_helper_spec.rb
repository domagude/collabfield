require 'rails_helper'
RSpec.describe Private::MessagesHelper, :type => :helper do
  context '#private_message_date_check' do
    let(:message) { create(:private_message) }
    let(:previous_message) { create(:private_message) }

    it "returns new_date partial's path" do
      message.update(created_at: 2.days.ago)
      expect(helper.private_message_date_check(message, previous_message)).to(
        eq 'private/messages/message/new_date'
      )
    end

    it "returns an empty partial's path" do
      expect(helper.private_message_date_check(message, previous_message)).to(
        eq 'shared/empty_partial'
      )
    end

    it "returns an empty partial's path" do
      previous_message = nil
      expect(helper.private_message_date_check(message, previous_message)).to(
        eq 'shared/empty_partial'
      )
    end
  end

  context '#sent_or_received' do
    let(:user) { create(:user) }
    let(:message) { create(:private_message) }
    it 'returns message-sent' do
      message.update(user_id: user.id)
      expect(helper.sent_or_received(message, user)).to eq 'message-sent'
    end

    it 'returns message-received' do
      expect(helper.sent_or_received(message, user)).to eq 'message-received'
    end
  end

  context '#seen_or_unseen' do
    let(:message) { create(:private_message) }
    it 'returns unseen' do
      message.update(seen: false)
      expect(helper.seen_or_unseen(message)).to eq 'unseen'
    end

    it 'returns nothing' do
      message.update(seen: true)
      expect(helper.seen_or_unseen(message)).to eq ''
    end
  end
  
end