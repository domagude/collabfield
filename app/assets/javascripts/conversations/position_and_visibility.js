$(document).on('turbolinks:load', function() { 
    chat_windows_count = $('.conversation-window').length;
    // if the last visible chat window is not set and conversation windows exist
    // set the last_visible_chat_window variable
    if (gon.last_visible_chat_window == null && chat_windows_count > 0) {
        gon.last_visible_chat_window = chat_windows_count;
    }
    // if gon.hidden_chats doesn't exist, set its value
    if (gon.hidden_chats == null) {
        gon.hidden_chats = 0;
    }
    window.addEventListener('resize', hideShowChatWindow);

    positionChatWindows();
    hideShowChatWindow();
});

function positionChatWindows() {
    chat_windows_count = $('.conversation-window').length;
    // if a new conversation window was added, 
    // set it as the last visible conversation window
    // so the hideShowChatWindow function can hide or show it, 
    // depending on the viewport's width
    if (gon.hidden_chats + gon.last_visible_chat_window !== chat_windows_count) {
        if (gon.hidden_chats == 0) {
            gon.last_visible_chat_window = chat_windows_count;
        }
    }

    // when a new chat window is added, position it to the most left of the list
    for (i = 0; i < chat_windows_count; i++ ) {
        var right_position = i * 410;
        var chat_window = i + 1;
        $('.conversation-window:nth-of-type(' + chat_window + ')')
            .css('right', '' + right_position + 'px');
    }
}

// Hides last conversation window whenever it is close to viewport's left side
function hideShowChatWindow() {
    // if there are no conversation windows, stop the function
    if ($('.conversation-window').length < 1) {
        return;
    }
    // get an offsset of the most left conversation window
    var offset = $('.conversation-window:nth-of-type(' + gon.last_visible_chat_window + ')').offset();
    // if the left offset of the conversation window is less than 50, 
    // hide this conversation window
    if (offset.left < 50 && gon.last_visible_chat_window !== 1) {
        $('.conversation-window:nth-of-type(' + gon.last_visible_chat_window + ')')
            .css('display', 'none');
        gon.hidden_chats++;
        gon.last_visible_chat_window--;
    }
    // if the offset of the most left conversation window is more than 550 
    // and there is a hidden conversation, show the hidden conversation
    if (offset.left > 550 && gon.hidden_chats !== 0) {
        gon.hidden_chats--;
        gon.last_visible_chat_window++;
        $('.conversation-window:nth-of-type(' + gon.last_visible_chat_window + ')')
            .css('display', 'initial');
    }
}
