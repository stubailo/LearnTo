# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  plus_response_url = "/comments/plus1.json?comment_id="

  $(".up-down-widget a.udw-top").click( (event) ->
    event.stopPropagation()
    event.preventDefault()
    response_id = $(this).parents(".response").attr("id").split("_")[2]
    $.post( plus_response_url + response_id, (data) ->
      $("#forum_response_" + response_id).find(".udw-middle").html(data["rating"])
      $("#forum_response_" + response_id).find(".udw-top").addClass("active")
      $("#forum_response_" + response_id).find(".udw-bottom").removeClass("active")
    )
  )
