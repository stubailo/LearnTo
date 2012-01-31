$ ->
  num_tabs = $(".featured_class_tabs li").length

  current_tab = 0 

  switch_to_tab = (which_tab) ->
    $(".display_case li.active").removeClass("active")
    $("#tab_" + which_tab).addClass("active")
    $(".featured_class_info").hide()
    $("#class_" + which_tab).show()
    $(".img_container img").css("zIndex", -2)
    my_img = $(".img_container #img_" + which_tab)
    my_img.css("zIndex", -1)
 
    current_tab = which_tab

    float(my_img)

  next_tab = ->
    switch_to_tab((current_tab + 1)%num_tabs)

  float = (element) ->
    element = $(element)
    my_height = element.innerHeight()
    container_height = element.parent().innerHeight()
    element.css("top", 0)
    element.animate( {top: -(my_height - container_height)}, 30000, 'linear', next_tab)
  
  $(window).ready -> 
    $("img").load -> switch_to_tab(0)
    $(".featured_class_tabs li").each ->
      tab_id = $(this).attr("id").split("_")[1]
      $(this).click ->
        switch_to_tab(tab_id)
      if $(".featured_class_tabs").innerHeight() < $(this).innerHeight()
        $(".featured_class_tabs").height($(this).innerHeight())
