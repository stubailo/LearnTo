->
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
        $.post(form_box.find("form").attr("action"), { "resource_comment[content]":text_box.val() }, insert_comment)

insert_comment = (response) ->
  alert("response")
