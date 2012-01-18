$ -> $(".button").button()

###
$ -> 
  $("#login_dialog").dialog({
    modal: true,
    autoOpen: false,
    title: "Sign in",
    resizable: false,
    width: "auto"
  })
  $("#sign_in_button").click (event) ->
    event.preventDefault()
    $("#login_dialog").dialog("open")
###

$ -> AudioPlayer.setup("/player.swf", {width: "100%", animation: "no"})

$ ->
  $(".javascript_show").show();
  $(".no_javascript").hide();

