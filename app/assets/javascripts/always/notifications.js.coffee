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
  nw.hide()
  nw.css("top",$("header").innerHeight())
  $(".header .top_level").css("position", "relative")
  $(".header .top_level").append(nw)

open_notifications = ->
  $(".notifications").addClass("opened")
  $.get( $(".notifications a").attr("href"), {"format":"json"}, success = load_notifications_callback )

load_notifications_callback = (data) ->
  nw.html(eval(data).notifications_html)
  $(".notifications a").text("X").addClass("has_notifications")
  nw.slideDown()
  $("body").one("click", handler = -> $(".notifications a").click() )

close_notifications = (event) ->
  $(".notifications").removeClass("opened")
  nw.slideUp()
  $(".notifications a").text("0").removeClass("has_notifications")
