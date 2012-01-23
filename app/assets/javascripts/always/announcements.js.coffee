# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  new_ann_form = $(".new_announcement_form")
  new_ann_form.hide()

  $("#post_new").toggle(
    (->
      new_ann_form.slideDown()
      $(this).parents(".announcements_box").find("h4").css("borderBottomStyle", "none")
      $(this).text("cancel new post")),
    (->
      new_ann_form.slideUp(callback = change_border)
      $(this).text("post new"))
    )

  change_border = ->
    $(this).parents(".announcements_box").find("h4").css("borderBottomStyle", "dashed")
    
