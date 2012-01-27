$ ->
  $(".image_embed").find(".image_container").height(100)
  $(".image_embed").each -> 
    the_image = $(this).find("img")
    the_image.load ->
      image_height = the_image.innerHeight()
      the_image.css("marginTop", image_height * -0.5 + 100)
      $(this).parents(".image_embed").find(".expand_image_preview").toggle(image_open, image_close)

image_open = (event) ->
  $(this).text("collapse preview")
  event.preventDefault()
  container = $(event.target).parents(".image_embed")
  container.find(".image_container").animate( {height: container.find("img").innerHeight()} )
  container.find("img").animate( {marginTop: 0})

image_close = ->
  $(this).text("expand preview")
  event.preventDefault()
  container = $(event.target).parents(".image_embed")
  container.find(".image_container").animate( {height: 100} )
  the_image = container.find("img")
  the_image.animate( {marginTop: the_image.innerHeight() * -0.5 + 100})
