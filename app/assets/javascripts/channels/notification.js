App.notification = App.cable.subscriptions.create("NotificationChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    // if a contact request was accepted
    if (data['notification'] == 'accepted-contact-request') {

    }
    // if a contact request was declined
    if (data['notification'] == 'declined-contact-request') {
      
    }
    // if a contact request was received
    if (data['notification'] == 'contact-request-received') {
      conversation_window = $('body').find('[data-pconversation-user-name="' + data["sender_name"] + '"]');
      has_no_contact_requests = $('#contacts-requests ul').find('.no-requests');
      contact_request = data['contact_request'];

      if (has_no_contact_requests.length) {
        // remove has no contact request message
        has_no_contact_requests.remove();
      }

      if (conversation_window.length) {
        // remove add user to contacts button
        conversation_window.find('.add-user-to-contacts-message').parent().remove();

        conversation_window.find('.add-user-to-contacts').remove();
        conversation_window.find('.conversation-heading').css('width', '360px');
      }

      // append a new contact request
      $('#contacts-requests ul').prepend(contact_request);
      calculateContactRequests();
    }

    // if a user was added to a new group conversation
    if (data['notification'] == 'added-to-group-conversation') {
      subToGroupConversationChannel(data['conversation_id']);
      $('#conversations-menu ul').prepend(data['link_to_conversation']);
      calculateUnseenConversations(); 
      if (gon.user_id == data['message_author']) {
        $('#conversations-menu ul li a')[0].click();
      }
    }

  },
  contact_request_response: function(sender_user_name, receiver_user_name, notification) {
    return this.perform('contact_request_response', {
      sender_user_name: sender_user_name,
    	receiver_user_name: receiver_user_name,
    	notification: notification
    });
  }
});
