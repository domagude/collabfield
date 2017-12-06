require "rails_helper"

RSpec.feature "window", :type => :feature do
  let(:user) { create(:user) }
  let(:conversation) { create(:private_conversation, sender_id: user.id) }
  let(:open_window) do
    sign_in user
    visit root_path
    find('#conversations-menu .dropdown-toggle').trigger('click')
    find('#conversations-menu li a').click
  end
  before(:each) do 
    conversation
    create(:private_message, conversation_id: conversation.id, user_id: user.id)
  end

  scenario 'user opens a conversation', js: true do
    open_window
    expect(page).to have_selector('.conversation-window')
  end

  scenario 'user closes a conversation', js: true do 
    open_window
    find('.conversation-window .close-conversation').trigger('click')
    expect(page.has_no_selector?('.conversation-window')).to eq true
  end

  scenario 'user sends a message', js: true do 
    open_window
    expect(page).to have_selector('.conversation-window .messages-list li', count: 1)
    find('.conversation-window').fill_in 'body', with: 'hey, mate'
    find('.conversation-window form .send-message', visible: false).trigger('click')
    expect(page).to have_selector('.conversation-window .messages-list li', count: 2)
  end

  scenario 'user collapses and expands a conversation window', js: true do
    open_window
    find('.conversation-window .conversation-heading').click
    expect(page).not_to have_selector('.conversation-window .messages-list')
  end
  
end