$ -> $(".button").button()

$ -> 
  $("#login_dialog").dialog({
    modal: true,
    autoOpen: false
  })
  $("#sign_in_button").click (event) ->
    event.preventDefault()
    $("#login_dialog").dialog("open")
    $("#login_dialog").load($("#sign_in_button").attr("href") + "_ajax")

