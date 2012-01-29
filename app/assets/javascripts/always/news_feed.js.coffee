$ ->
  $(".teacher_post_feed .feed_forum_post").each ->  
    the_post = $(this)
    more_link = the_post.find(".more_link")
    more_link.click (event) ->
      event.preventDefault()
      more_link.hide()
      the_post.find(".more").fadeIn()
