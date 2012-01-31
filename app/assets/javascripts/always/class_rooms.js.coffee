# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  why_link = $("<small> - <a href='#' style='color: #c05f00'>what does this mean?</a></small>")
  why_link.css("fontSize", ".7em")
  why_link.css("fontWeight", "normal")
  $(".class_room_start_bar h3").append(why_link)
  why_link.click ->
    $(".hidden_explanation").slideDown()
    why_link.remove()
