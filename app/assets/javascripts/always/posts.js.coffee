# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  if $(".edit_post").length > 0
    $(".edit_post").each ->
      the_form = $(this)
      the_container = $(this).parents(".forum_post_container")
      edit_link = $("<a href='#' class='.edit_link'>edit</a>")
      edit_link.css("float", "right").css("paddingRight", "5px")
      the_container.find(".forum_post").find(".delete_link").after(edit_link)
      edit_link.click ->
        the_container.find(".forum_post").css("background", "#f00")
        
