$(document).on('turbolinks:load ajax:complete', function() {
    var iScrollPos = 0;
    var isLoading = false;
    var currentLoadingIcon;

    $(document).ajaxComplete(function() {
        isLoading = false;
        // hide loading icon
        if (currentLoadingIcon !== undefined) {
            currentLoadingIcon.hide();
        }
    });

    $('.messages-list', this).scroll(function () {
        var iCurScrollPos = $(this).scrollTop();
        if (iCurScrollPos > iScrollPos) {
            //Scrolling Down
        } else {
           //Scrolling Up
           if (iCurScrollPos < 300 && isLoading == false && $('.load-more-messages', this).length) {
                isLoading = true;
                // trigger link, which loads 10 more messages
                $('.load-more-messages', this)[0].click();
                
                // select conversation window's loading icon and show it
                currentLoadingIcon = $('.loading-more-messages', this);
                currentLoadingIcon.show();
           }
        }
        iScrollPos = iCurScrollPos;
    });
});