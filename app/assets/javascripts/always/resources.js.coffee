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
