$ ->
  $(".notifications a").toggle( open_notifications, close_notifications)

open_notifications = ->
  $(".notifications").addClass("opened")

close_notifications = ->
  $(".notifications").removeClass("opened")
