# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".up-down-widget a.udw-top").click( pm_event_handler("plus") )
  $(".up-down-widget a.udw-bottom").click( pm_event_handler("minus") )

  $(".new_comment").submit ( ajax_response_submit_handler )
  init_comments()

ajax_response_submit_handler = (event) ->
  event.preventDefault()
  if $(event.target).find("textarea").val() != ""
    data = {}
    $(event.target).find("[name]").each ->
      data[$(this).attr("name")] = $(this).attr("value")
    data["format"] = "json"
    $.post($(event.target).attr("action"), data, new_comment_callback)

new_comment_callback = (response) ->
  $(".forum_post_responses").find(".post_response_form").before(eval(response).new_comment)
  init_comments()

init_comments = ->
  subcomment_form = $(".sub_comments").find("form")
  subcomment_form.find("[type=submit]").hide()
  text_area = subcomment_form.find("textarea")
  text_area.height("3em")
  text_area.addClass("inactive")
  
  textarea_default_text = "Write a comment..."

  text_area.val(textarea_default_text)

  text_area.focus ->
    text_area.val("") if text_area.val() == textarea_default_text
    text_area.removeClass("inactive")
  text_area.blur ->
    if text_area.val() == ""
      text_area.val(textarea_default_text) 
      text_area.addClass("inactive")

  text_area.keydown (event) ->
    if event.keyCode == 13
      event.preventDefault()
      $.post(subcomment_form.attr("action"), {"subcomment[content]":text_area.val(), "format":"json"}, subcomment_callback)

  subcomment_callback = (response) ->
    subcomment_form.before(eval(response).new_subcomment)
    

pm_event_handler = (plus_or_minus) ->
  (event) ->
    widget = $(this).parents(".up-down-widget")
    switch plus_or_minus
      when "plus"
        bottom_or_top = "top"
        opposite = "bottom"
        increment = 1
      when "minus"
        bottom_or_top = "bottom"
        opposite = "top"
        increment = -1
    event.stopPropagation()
    event.preventDefault()
    $.post( $(this).attr("href"), data = {"format" : "json"}, success = (data) ->
      middle = widget.find(".udw-middle")
      if widget.find(".udw-" + opposite).hasClass("active")
        increment *= 2 
        widget.find(".udw-" + bottom_or_top).addClass("active")
        widget.find(".udw-" + opposite).removeClass("active")
      else if widget.find(".udw-" + bottom_or_top).hasClass("active")
        increment = -1 * increment
        widget.find(".udw-" + bottom_or_top).removeClass("active")
      else
        widget.find(".udw-" + bottom_or_top).addClass("active")
        
      middle.text(parseInt(middle.text()) + increment)
    )

$ ->
  cancel_button = $("<a href='#' style='float:right' class='cancel_button'>cancel</a>")
  $(".new_post_container").prepend(cancel_button)
  cancel_button.hide()
  cancel_button.click ->
    $("#new_post").parent().slideUp()
    cancel_button.hide()
  $("#new_post_button").click ->
    $("#new_post").parent().slideDown()
    cancel_button.show()
