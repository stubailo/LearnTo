# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.SyntaxHighlighter.init()

$ -> $(".media-resource").each (index, element) -> 
  hide_button = $(document.createElement("a"))
    .addClass("resource-show-hide resource-hide")
    .attr("href", "#")
    .append("hide preview")
    .click (event) -> 
      event.preventDefault()
      $(element).find(".inside").slideUp()
      $(element).find(".resource-show").show()
      $(element).find(".resource-hide").hide()
    .appendTo $(element).find(".title").first()

  show_button = $(document.createElement("a"))
    .addClass("resource-show-hide resource-show")
    .attr("href", "#")
    .append("show preview")
    .click (event) ->
      event.preventDefault()
      $(element).find(".inside").slideDown()
      $(element).find(".resource-hide").show()
      $(element).find(".resource-show").hide()
    .appendTo $(element).find(".title").first()
  if $(element).find(".inside").is(":visible")
    show_button.hide()
  else
    hide_button.hide()

$ -> 
  $(".type_radio_buttons").buttonset()
  $(".add_resource_form").addClass("form_page")
  $(".upload_box .title").append($("<a href='#' id='cancel_button' style='float: right'>Cancel</a>").hide())
  $("[id$=_tab_contents]").hide();
  $(".upload_links a").click (event) ->
    $(".upload_box").addClass("active")
    $("#cancel_button").show()
    element = $(event.target)
    $(".upload_links").fadeOut()
    $(".add_resource_form").slideDown()
    $("input:radio[value=" + element.attr("id")[9..-1] + "]").attr("checked", true)
    $("label[for$=" + element.attr("id")[9..-1] + "] span").click()
    $(".type_radio_buttons").buttonset("refresh")
  $("#cancel_button").click (event) ->
    event.preventDefault()
    $(".upload_box").removeClass("active")
    $("#cancel_button").hide()
    $(".upload_links").fadeIn()
    $(".add_resource_form").slideUp()
  $("label[for^='resource_file_type_']").click (event) ->
    val = $(event.target).parent().attr("for").split("_")[3]
    $(".type_radio_buttons>input:radio").attr("checked", false)
    $("input:radio[value=" + val + "]").attr("checked", true)
    $("[id$=_tab_contents]").hide();
    $("#" + val + "_tab_contents").show();
