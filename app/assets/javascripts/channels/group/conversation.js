for (i = 0; i < gon.group_conversations.length; i++) {
    subToGroupConversationChannel(gon.group_conversations[i]);
}

function subToGroupConversationChannel(id) {
    App['group_conversation_' + id]  = App.cable.subscriptions.create(
        {
            channel: 'Group::ConversationChannel',
            id: id
        },
        {
            connected: function() {},
            disconnected: function() {},
            received: function(data) {
                // prepend link to the conversation 
                // to the top of conversations menu list
                modifyConversationsMenuList(data['conversation_id']);

                // set variables
                var conversation = findConv(data['conversation_id'], 'g');
                var conversation_rendered = ConvRendered(data['conversation_id'], 'g');
                var messages_visible = ConvMessagesVisiblity(conversation);

                // if the message is not sent by the user, 
                // mark the conversation as unseen
                MarkGroupConvAsUnseen(data['user_id'], data['conversation_id']);

                // append the new message
                appendGroupMessage(conversation_rendered, 
                                   messages_visible, 
                                   conversation,
                                   data['message']);

                // if the conversation window is rendered
                if (conversation_rendered) {
                    // after the new message was appended 
                    // scroll to the bottom of the conversation window
                    var messages_list = conversation.find('.messages-list');
                    var height = messages_list[0].scrollHeight;
                    messages_list.scrollTop(height);
                }
                
            },
            send_message: function(message) {
                return this.perform('send_message', {
                    message: message
                });
            },
            set_as_seen: function(conv_id) {
                return this.perform('set_as_seen', { conv_id: conv_id });
            }
        }
    );
}

$(document).on('submit', '.send-group-message', function(e) {
    e.preventDefault();
    var id = $(this).find('input[name=conversation_id]').val();
    var message_values = $(this).serializeArray();
    App['group_conversation_' + id].send_message(message_values);
});

// if the last message in the conversation is not seen by the user
// mark unseen messages as seen
$(document).on('click', '.conversation-window, .group-conversation', function(e) {
    var latest_message = $('.messages-list ul li:last .row', this);
    var unseen_by_user = latest_message.hasClass('unseen');
    // if not seen by the user
    if (unseen_by_user) {
        var conv_id = $(this).find('.panel').attr('data-gconversation-id');
        // if conv_id doesn't exist, it means that message was seen in messenger
        if (conv_id == null) {
            var conv_id = $(this).find('.messages-list').attr('data-gconversation-id');
        }
        // mark conversation as seen in conversations menu list
        $('#menu-gc' + conv_id).removeClass('unseen-conv');
        latest_message.removeClass('unseen');
        calculateUnseenConversations();
        App['group_conversation_' + conv_id].set_as_seen(conv_id);
    }
});

function MarkGroupConvAsUnseen(message_user_id, conversation_id) {
     // if the message is not sent by the user, mark the conversation as unseen
    if (message_user_id != gon.user_id) {
        newGroupConvMenuListLink(conversation_id);

        // mark the conversation as unseen, after the new message is received
        $('#menu-gc' + conversation_id).addClass('unseen-conv');
        calculateUnseenConversations();
    }
                  
}

// prepend link to the conversation to the top of conversations menu list
function modifyConversationsMenuList(conversation_id) {
    // if the conversation link in conversations menu list exists
    // move conversation link to the top of the conversations menu list
    var conversation_menu_link = $('#conversations-menu ul')
                                     .find('#menu-gc' + conversation_id);
    if (conversation_menu_link.length) {
        conversation_menu_link.prependTo('#conversations-menu ul');
    }
}

// append the new message to the list
function appendGroupMessage(conversation_rendered, 
                            messages_visible, 
                            group_conversation,
                            message) {
    if (conversation_rendered) {
        // if the conversation is collapsed
        if (!messages_visible) {
            // mark its header color
        }
        // append the new message to the list
        group_conversation
            .find('.messages-list')
            .find('ul')
            .append(message);
    }

}

// if the conversation link in the conversations menu list doesn't exist
// create a new link with the receiver's name and prepend it to the list
function newGroupConvMenuListLink(conversation_id) {
    var id_attr = '#menu-gc' + conversation_id;
    var conversation_menu_link = $('#conversations-menu ul').find(id_attr);
    if (conversation_menu_link.length == 0) {
        var list_item = '<li class="conversation-window">\
                             <a data-remote="true"\
                                rel="nofollow"\
                                data-method="post"\
                                href="/group_conversations?group_conversation_id=' +  conversation_id + '">\
                                    group conversation\
                             </a>\
                         </li>';
        $('#conversations-menu ul').prepend(list_item);
    }
}