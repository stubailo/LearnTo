
$ ->
  $(".image_embed").find(".image_container").height(100)
  $(".image_embed").each -> 
    container = $(this)
    the_image = $(this).find("img")
    the_image.load ->
      image_height = the_image.innerHeight()
      the_image.css("marginTop", image_height * -0.5 + 100)
      
      image_open = (event) ->
        $(this).text("collapse preview")
        event.preventDefault()
        container.find(".image_container").animate( {height: container.find("img").innerHeight()} )
        container.find("img").animate( {marginTop: 0})

      image_close = (event)->
        $(this).text("expand preview")
        event.preventDefault()
        container.find(".image_container").animate( {height: 100} )
        the_image.animate( {marginTop: the_image.innerHeight() * -0.5 + 100})
      
      container.find(".expand_image_preview").toggle(image_open, image_close)
