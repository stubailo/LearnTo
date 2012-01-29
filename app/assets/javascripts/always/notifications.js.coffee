nw = ""

$ ->
  $(".notifications a").toggle( open_notifications, close_notifications)
  tab = $(".notifications")
  tab.height($("header").innerHeight()+1)
  tab.css("marginBottom", "-1px")
  tab.css("zIndex", "1000")
  $(".notifications").css("position", "relative")

  create_notifications_window()


create_notifications_window = ->
  nw = $("<div></div>").addClass("notifications_window")
  nw.height(300)
  nw.hide()
  nw.css("top",$("header").innerHeight()+1)
  $("header .top_level").css("position", "relative")
  $("header .top_level").append(nw)

open_notifications = ->
  $(".notifications").addClass("opened")
  nw.slideDown()
  $(".notifications a").text("X").addClass("has_notifications")
  $.get( $(".notifications a").attr("href"), {"format":"json"}, load_notifications_callback )

  load_notifications_callback = (response) ->
    nw.html(eval(response).notifications_html)

close_notifications = ->
  $(".notifications").removeClass("opened")
  nw.slideUp()
  $(".notifications a").text("0").removeClass("has_notifications")
