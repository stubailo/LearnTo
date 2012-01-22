# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  new_ann_form = $(".new_announcement_form")
  new_ann_form.hide()

  $("#post_new").toggle(
    (->
      new_ann_form.slideDown()
      $(this).text("cancel new post")),
    (->
      new_ann_form.slideUp()
      $(this).text("post new"))
    )
