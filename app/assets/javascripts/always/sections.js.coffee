# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->


  #make homework completed links into ajaxy checkboxes
  $(".homework_completed_link").each ->
    $(this).hide()
    the_resource = $(this).parents("li[id^=resource]")
    the_checkbox = $("<input type='checkbox' class='completed_checkbox' />")
    the_resource.find(".resource_list_name").prepend(the_checkbox)
    if the_resource.hasClass("completed") then the_checkbox.attr("checked", "checked")
    url = $(this).attr("href")
    the_checkbox.change ->
      $.get(url)
      if the_resource.hasClass("completed") then the_resource.switchClass("completed", "")  else the_resource.switchClass("", "completed")

  #make delete links ajaxy
  $(".lists_to_connect a[data-method=delete]").each ->
    $(this).click ->
      event.preventDefault()
      event.stopPropagation()

      the_resource = $(this).parents("li[id^=resource]")

      if $(this).hasClass("confirm_alert")
        the_resource.slideUp()
        $.ajax({
          url: $(this).attr("href"),
          type: 'DELETE'})
      else 
        delete_link = $(this)
        delete_link.text("click again to delete")
        delete_link.addClass("confirm_alert")

        $("body").one "click", handler = ->
          delete_link.removeClass("confirm_alert")
          delete_link.text("delete")

  #make hide links ajaxy
  $(".lists_to_connect a.hide_link").each ->
    $(this).click ->
      event.preventDefault()
      event.stopPropagation()

      the_resource = $(this).parents("li[id^=resource]")

      if the_resource.hasClass("hidden")
        $(this).text("hide")
        the_resource.switchClass("hidden", "")
        $.ajax({url: $(this).attr("href")})
        the_resource.find(".hidden_indicator").text("")
      else 
        $(this).text("publish")
        the_resource.switchClass("", "hidden")
        $.ajax({url: $(this).attr("href")})
        the_resource.find(".hidden_indicator").text("(hidden)")


  if typeof allow_draggable != 'undefined'
    $(".list_of_sections").sortable({
      axis: "y",
      stop: (event, ui) ->
        action_path = ui.item.find("form").attr("action")
        index = $(ui.item.parent()).find("li").index(ui.item)
        $.post(action_path, {"section[order]" : index})
    });

    $(".lists_to_connect").sortable({
      axis: "y",
      connectWith: ".lists_to_connect",
      stop: (event, ui) ->
        action_path = ui.item.find("form").attr("action")
        section_id = $(ui.item.parent()).attr("id").split("-")[1]
        index = $(ui.item.parent()).find("li").index(ui.item)
        $.post(action_path, {"section[id]" : section_id, "resource[order]" : index})
    })
  
  $(".list_of_sections").find("form").hide()

  $(".rename_section_link").click (event) ->
    the_heading = $(this).parents(".materials_section").find("h3")
    the_heading.prepend("<div class='rename_section_inputs'></div>")
    input_section = the_heading.find(".rename_section_inputs")
    input_section.prepend("<a href='#' class='rename_section_submit button'>Save</a>")
    input_section.prepend("<input class='rename_section_field' />")
    input_section.find(".rename_section_submit").button()
    input_section.find(".rename_section_field").val(the_heading.find("span.name").text())
    the_heading.find("span.name").hide()
    the_heading.find(".rename_section_link").hide()

    submit_new_name = ->
      the_action = the_heading.parents(".materials_section").find(".rename_section_form_container").find("form").attr("action")
      the_new_name = input_section.find(".rename_section_field").val()
      $.post( the_action, data = {"section[title]":the_new_name} )
      the_heading.find("span.name").text(the_new_name)
      the_heading.find("span.name").show()
      input_section.remove()
      the_heading.find(".rename_section_link").show()

    input_section.find(".rename_section_submit").click (event) ->
      submit_new_name()

    input_section.find(".rename_section_field").keydown (event) ->
      if event.keyCode == 13
        submit_new_name()
