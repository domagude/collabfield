$(document).on('turbolinks:load', function() {
  var isLoading = false;
  if ($('.infinite-scroll', this).size() > 0) {
    $(window).on('scroll', function() {
      var more_posts_url = $('.pagination a.next_page').attr('href');
      var threshold_passed = $(window).scrollTop() > $(document).height() - $(window).height() - 60;
      if (!isLoading && more_posts_url && threshold_passed) {
        isLoading = true;
        $.getScript(more_posts_url).done(function (data,textStatus,jqxhr) {
          isLoading = false;
        }).fail(function() {
          isLoading = false;
        });
      }
    });
  }
});