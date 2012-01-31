nw = ""

sleep = (options..., callback) ->
    [period, repeat] = options
    method = if repeat then setInterval else setTimeout
    method callback, period or 0

$ ->
  $(".notifications a").click( open_notifications )
  tab = $(".notifications")
  tab.height($("header").innerHeight()+1)
  tab.css("marginBottom", "-1px")
  tab.css("zIndex", "1000")
  $(".notifications").css("position", "relative")

  create_notifications_window()

  if $(".notifications").size() > 0
    sleep 10000, yes, check_for_notifications

check_for_notifications = ->
  unless $(".notifications").hasClass("opened")
    $.get("/users/1/notifications/count.json", update_notification_number)

set_titlebar_number = (n) ->
  if document.title[0] == "("
    if n > 0 
      document.title = "(" +n+ ") " + document.title.split(" ")[1]
    else
      document.title = document.title.split(" ")[1]
  else
    if n > 0
      document.title = "(" +n+ ") " + document.title

update_notification_number = (response) ->
  n = eval(response).count
  unless $(".notifications").hasClass("opened")
    $(".notifications a").text(n)
    set_titlebar_number(n)
    if n > 0
      $(".notifications a").addClass("has_notifications")
    else
      $(".notifications a").removeClass("has_notifications")

  
create_notifications_window = ->
  nw = $("<div></div>").addClass("notifications_window")
  nw.hide()
  nw.css("top",$("header").innerHeight())
  $(".header .top_level").css("position", "relative")
  $(".header .top_level").append(nw)

open_notifications = (event) ->
  event.stopPropagation()
  event.preventDefault()
  $(".notifications").addClass("opened")
  $.get( $(".notifications a").attr("href"), {"format":"json"}, success = load_notifications_callback )
  $(".notifications a").unbind("click")
  $(".notifications a").click (close_notifications)

load_notifications_callback = (data) ->
  nw.html(eval(data).notifications_html)
  sa = $("<div></div>").addClass("see_all")
  link = $("<a>see all</a>").attr("href", $(".notifications a").attr("href"))
  sa.append(link)
  nw.append(sa) unless nw.find(".empty_notifications").size() > 0
  $(".notifications a").text("X").addClass("has_notifications")
  nw.slideDown()

close_notifications = (event) ->
  event.preventDefault()
  $(".notifications").removeClass("opened")
  nw.slideUp()
  $(".notifications a").text("0").removeClass("has_notifications")
  set_titlebar_number(0)
  $(".notifications a").unbind("click")
  $(".notifications a").click( open_notifications )
