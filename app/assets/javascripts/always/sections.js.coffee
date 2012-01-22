# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->

  $(".lists_to_connect").find("form").hide()
  
  $(".list_of_sections").sortable();

  $(".lists_to_connect").sortable({
    connectWith: ".lists_to_connect",
    stop: (event, ui) ->
      action_path = ui.item.find("form").attr("action")
      section_id = $(ui.item.parent()).attr("id").split("-")[1]
      index = $(ui.item.parent()).find("li").index(ui.item)
      $.post(action_path, {"section[id]" : section_id, "resource[order]" : index})
  })
