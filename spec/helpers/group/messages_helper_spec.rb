require 'rails_helper'

RSpec.describe Group::MessagesHelper, type: :helper do

  context '#group_message_seen_by' do
    let(:message) { create(:group_message) }
    it 'returns an array with users' do
      users = create_list(:user, 2)
      users.each do |user|
        message.seen_by << user.id
      end
      message.save
      users.map! { |user| user.name }
      expect(helper.group_message_seen_by(message)).to eq users
    end

    it 'returns an empty array' do
      users = []
      expect(helper.group_message_seen_by(message)).to eq users
    end
  end

  context '#message_content_partial_path' do
    let(:user) { create(:user) }
    let(:message) { create(:group_message) }
    let(:previous_message) { create(:group_message) }

    it "returns same_user_content partial's path" do
      previous_message.update(user_id: user.id)
      expect(helper.message_content_partial_path(user, 
                                                 message, 
                                                 previous_message)).to eq(
        'group/messages/message/same_user_content'
      )
    end

    it "returns different_user_content partial's path" do
      expect(helper.message_content_partial_path(user, 
                                                 message, 
                                                 previous_message)).to eq(
        'group/messages/message/different_user_content'
      )
    end

    it "returns different_user_content partial's path" do
      previous_message = nil
      expect(helper.message_content_partial_path(user, 
                                                 message, 
                                                 previous_message)).to eq(
        'group/messages/message/different_user_content'
      )
    end
  end

  context '#group_message_date_check_partial_path' do
    let(:new_message) { create(:group_message) }
    let(:previous_message) { create(:group_message) }

    it "returns a new_date partial's path" do
      new_message.update(created_at: 2.days.ago)
      expect(helper.group_message_date_check_partial_path(new_message, 
                                                          previous_message)).to eq(
        'group/messages/message/new_date'
      )
    end

    it "returns an empty partial's path" do
      expect(helper.group_message_date_check_partial_path(new_message, 
                                                          previous_message)).to eq(
        'shared/empty_partial'
      )
    end

    it "returns an empty partial's path" do
      previous_message = nil
      expect(helper.group_message_date_check_partial_path(new_message, 
                                                          previous_message)).to eq(
        'shared/empty_partial'
      )
    end
  end

end
