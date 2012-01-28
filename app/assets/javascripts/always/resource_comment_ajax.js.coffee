$ ->

  set_spacing()

  activate_delete_links()
  
  form_box = $(".new_resource_comment_form")
  form_box.find("input[type=submit]").hide()
  text_box = form_box.find("textarea")
  text_box.val("Write a comment...")
  text_box.addClass("inactive")

  text_box.focus ->
    if text_box.val() == "Write a comment..."
      text_box.val("")
    text_box.removeClass("inactive")

  text_box.blur ->
    if text_box.val() == ""
      text_box.val("Write a comment...")
      text_box.addClass("inactive")

  text_box.keydown (event) ->
    if event.keyCode == 13 and not event.shiftKey
      event.preventDefault()
      if text_box.val() != ""
        $.post(form_box.find("form").attr("action"), { "resource_comment[content]":text_box.val(), format: "json" }, insert_comment)
        text_box.val("")

set_spacing = ->
  $(".resource_sub_comments").css("minHeight", $(".resource_sub_comments").innerHeight() + 100)

update_comment_count = ->
  container = $(".resource_sub_comments")
  new_count = container.find(".resource_comment").length
  new_text = new_count.toString() + (if new_count == 1 then " comment" else " comments")
  container.find("h3").text(new_text)

activate_delete_links = ->
  $(".resource_comment a[data-method=delete]").click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $.ajax($(this).attr("href"), {type: 'DELETE'})
    $(this).parents(".resource_comment").fadeOut -> 
      $(this).remove()
      update_comment_count()

insert_comment = (response) ->
  new_comment = $(eval(response)["comment_html"]).hide()
  $(".resource_sub_comments").find(".new_resource_comment_form").before( new_comment )
  new_comment.slideDown()
  activate_delete_links()
  update_comment_count()
