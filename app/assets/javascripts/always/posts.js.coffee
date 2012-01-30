# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  if $(".edit_post").length > 0
    $(".edit_post").each ->
      the_form = $(this)
      the_form.remove()
      the_form.hide()
      $(".the_post .post_content").after(the_form)

      the_container = $(this).parents(".forum_post_container")
      edit_link = $("<a href='#' class='edit_link'>edit</a>")
      edit_link.css("float", "right").css("paddingRight", "5px")
      the_container.find(".forum_post").find(".delete_link").after(edit_link)
      open_edit = ->
        the_form.show()
        $(".post_content").hide()
        $(".button").button()
      close_edit = ->
        the_form.hide()
        $(".post_content").show() 
      edit_link.toggle(open_edit, close_edit)
      
    

