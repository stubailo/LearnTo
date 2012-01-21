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

$ ->
  search_box = $(".search_box").find("input.text")
  search_box.addClass("inactive").val("find a class...")
    .focus ->
      if search_box.hasClass("inactive")
        search_box.val("").addClass("active").removeClass("inactive")
    .blur ->
      if search_box.val() == ""
        search_box.addClass("inactive").removeClass("active").val("find a class...")
      
