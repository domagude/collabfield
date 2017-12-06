// finds a conversation in the DOM
function findConv(conversation_id, type) {
    // if a current conversation is opened in the messenger
    var messenger_conversation = $('body .conversation');
    if (messenger_conversation.length) {
        // conversation is opened in the messenger
        return messenger_conversation;
    } else { 
        // conversation is opened in a popup window
        var data_attr = "[data-" + type + "conversation-id='" + 
                         conversation_id + 
                         "']";
        var conversation = $('body').find(data_attr);
        return conversation;
    }
}

// checks if a conversation window is rendered and visible on a browser
function ConvRendered(conversation_id, type) {
    // if a current conversation is opened in the messenger
    if ($('body .conversation').length) {
        // conversation is opened in the messenger
        // so it automatically means that is visible
        return true;
    } else { 
        // conversation is opened in a popup window
        var data_attr = "[data-" + type + "conversation-id='" + 
                         conversation_id + 
                         "']";
        var conversation = $('body').find(data_attr);
        return conversation.is(':visible');
    }
}

function ConvMessagesVisiblity(conversation) {
    // if current conversation is opened in the messenger
    if ($('body .conversation').length) {
        // conversation is opened in the messenger
        // so it is automatically means that messages are visible
        return true;
    } else {
        // conversation is opened in a popup window
        // check if the window is collapsed or expanded
        var visibility = conversation
                             .find('.panel-body')
                             .is(':visible');
        return visibility;
    }
}