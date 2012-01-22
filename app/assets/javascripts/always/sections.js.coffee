# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  $(".lists_to_connect").find("form").hide()

  $(".lists_to_connect").sortable({
    connectWith: ".lists_to_connect",
  }).droppable({
    drop: (event, ui) -> 
      section_id = $(this).attr("id").split("-")[1]
      resource_id = ui.draggable.attr("id").split("-")[1]
      index = $(this).index(ui.draggable)
      action_path = ui.draggable.find("form").attr("action")
      
      $.post(action_path, {"section[id]" : section_id, "resource[order]" : index})
  })

