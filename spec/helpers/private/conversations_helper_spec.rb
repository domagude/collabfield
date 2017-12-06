require 'rails_helper'

RSpec.describe Private::ConversationsHelper, type: :helper do
  let(:current_user) { create(:user) }
  let(:recipient) { create(:user) }

  
  context '#load_private_messages' do
    let(:conversation) { create(:private_conversation) }

    it "returns load_messages partial's path" do
      create(:private_message, conversation_id: conversation.id)
      expect(helper.load_private_messages(conversation)).to eq (
        'private/conversations/conversation/messages_list/link_to_previous_messages'
      )
    end

    it "returns empty partial's path" do
      expect(helper.load_private_messages(conversation)).to eq (
        'shared/empty_partial'
      )
    end
  end

  context '#add_to_contacts_partial_path' do
    let(:contact) { create(:contact) }

    it "returns an empty partial's path" do
      helper.stub(:recipient_is_contact?).and_return(true)
      expect(helper.add_to_contacts_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end

    it "returns add_user_to_contacts partial's path" do
      helper.stub(:recipient_is_contact?).and_return(false)
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.add_to_contacts_partial_path(contact)).to eq(
        'private/conversations/conversation/heading/add_user_to_contacts' 
      )
    end
  end

  context '#get_contact_record' do
    it 'returns a Contact record' do
      contact = create(:contact, user_id: current_user.id, contact_id: recipient.id)
      helper.stub(:current_user).and_return(current_user)
      expect(helper.get_contact_record(recipient)).to eq contact
    end
  end

  context '#unaccepted_contact_request_partial_path' do
    let(:contact) { contact = create(:contact) }

    it "returns sent_by_current_user partial's path" do
      helper.stub(:unaccepted_contact_exists).and_return(true)
      helper.stub(:request_sent_by_user).and_return(true)
      expect(helper.unaccepted_contact_request_partial_path(contact)).to eq(
        'private/conversations/conversation/request_status/sent_by_current_user' 
      )
    end

    it "returns sent_by_recipient partial's path" do
      helper.stub(:unaccepted_contact_exists).and_return(true)
      helper.stub(:request_sent_by_user).and_return(false)
      expect(helper.unaccepted_contact_request_partial_path(contact)).to eq(
        'private/conversations/conversation/request_status/sent_by_recipient'
      )
    end

    it "returns an empty partial's path" do
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.unaccepted_contact_request_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end
  end

  context '#not_contact_no_request' do
    let(:contact) { contact = create(:contact) }

    it "returns send_request partial's path" do
      helper.stub(:recipient_is_contact?).and_return(false)
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.not_contact_no_request_partial_path(contact)).to eq(
        'private/conversations/conversation/request_status/send_request'
      )
    end

    it "returns an empty partial's path" do
      helper.stub(:recipient_is_contact?).and_return(true)
      helper.stub(:unaccepted_contact_exists).and_return(false)
      expect(helper.not_contact_no_request_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end

    it "returns an empty partial's path" do
      helper.stub(:recipient_is_contact?).and_return(false)
      helper.stub(:unaccepted_contact_exists).and_return(true)
      expect(helper.not_contact_no_request_partial_path(contact)).to eq(
        'shared/empty_partial'
      )
    end
  end

  context '#conv_heading_class' do
    let(:contact) { create(:contact) }

    it 'returns a conversation-heading-full class' do
      contact.update(accepted: false)
      expect(helper.conv_heading_class(contact)).to eq 'conversation-heading-full'
    end

    it 'returns a conversation-heading class' do
      contact.update(accepted: true)
      expect(helper.conv_heading_class(contact)).to eq 'conversation-heading'
    end
  end

  context '#contacts_except_recipient' do
    it 'return all contacts, except the opposite user of the chat' do
      contacts = create_list(:contact, 
                              5, 
                              user_id: current_user.id, 
                              accepted: true)
      
      contacts << create(:contact, 
                          user_id: current_user.id, 
                          contact_id: recipient.id,
                          accepted: true)
      helper.stub(:current_user).and_return(current_user)
      expect(helper.contacts_except_recipient(recipient)).not_to include recipient
    end
  end

  context '#create_group_conv_partial_path' do
    let(:contact) { create(:contact) }

    it "returns a create_group_conversation partial's path" do 
      helper.stub(:recipient_is_contact?).and_return(true)
      expect(helper.create_group_conv_partial_path(contact)).to(
        eq 'private/conversations/conversation/heading/create_group_conversation'
      )
    end

    it "returns an empty partial's path" do 
      helper.stub(:recipient_is_contact?).and_return(false)
      expect(helper.create_group_conv_partial_path(contact)).to(
        eq 'shared/empty_partial'
      )
    end
  end

  context 'private scope' do
    context '#unaccepted_contact_exists' do
      it 'returns false' do
        contact = create(:contact, accepted: true)
        expect(helper.instance_eval {
          unaccepted_contact_exists(contact)
        }).to eq false
      end

      it 'returns false' do
        contact = nil
        expect(helper.instance_eval {
          unaccepted_contact_exists(contact)
        }).to eq false
      end

      it 'returns true' do
        contact = create(:contact, accepted: false)
        expect(helper.instance_eval {
          unaccepted_contact_exists(contact)
        }).to eq true
      end
    end

    context '#recipient_is_contact?' do
      it 'returns false' do
        helper.stub(:current_user).and_return(current_user)
        assign(:recipient, recipient)
        create_list(:contact, 2, user_id: current_user.id, accepted: true)
        expect(helper.instance_eval { recipient_is_contact? }).to eq false
      end

      it 'returns true' do
        helper.stub(:current_user).and_return(current_user)
        assign(:recipient, recipient)
        create_list(:contact, 2, user_id: current_user.id, accepted: true)
        create(:contact, 
                user_id: current_user.id, 
                contact_id: recipient.id, 
                accepted: true)
        expect(helper.instance_eval { recipient_is_contact? }).to eq true
      end
    end

    context '#request_sent_by_user' do
      it 'returns true' do
        contact = create(:contact, user_id: current_user.id)
        helper.stub(:current_user).and_return(current_user)
        expect(helper.instance_eval { request_sent_by_user(contact) }).to eq true
      end

      it 'returns false' do
        contact = create(:contact, user_id: recipient.id)
        helper.stub(:current_user).and_return(current_user)
        expect(helper.instance_eval { request_sent_by_user(contact) }).to eq false
      end
    end
  end
  
end
