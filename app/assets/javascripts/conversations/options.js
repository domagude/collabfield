$(document).on('turbolinks:load', function() { 

    //  when add more contacts to a conversation button is clicked
    //  toggle contacts selection
    $('body').on('click', '.add-people-to-chat', function(e) {
        $(this).next().toggle(100, 'swing');
    });

    // on the add-user-to-contacts link click
    // remove the link and notify, that the request has been sent
    $(document).on('click', 
                   '.add-user-to-contacts, .add-user-to-contacts-notif', 
                   function(e) {
        var conversation_window = $(this).parents('.conversation-window,\
                                                   .conversation');
        conversation_window
            .find('.add-user-to-contacts')
            .replaceWith('<div class="contact-request-sent"\
                               style="display: block;">\
                              <div>\
                                  <i class="fa fa-question"\
                                     aria-hidden="true"\
                                     title="Contact request sent">\
                                  </i>\
                              </div>\
                          </div>');
        conversation_window.find('.add-user-to-contacts-message').remove();
        conversation_window
            .find('.messages_list ul')
            .append('<div class="add-user-to-contacts-message">\
                         Contact request sent\
                     </div>');
    });
});