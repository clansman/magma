height = 5
width = 5
SIZE = 100
deg = 0
tilearray = []
imagearray = [
  "url(http://indulgy.ccio.co/NB/88/JE/0fd57ce1955a2bf5f2060c83bbd9bfac.jpg)",
  "url(http://s5.favim.com/orig/51/apple-steve-jobs-black-and-white-face-Favim.com-465544.jpg)",
  "url(http://www.creoglassonline.co.uk/ekmps/shops/bohdan/images/black-cat-face-[2]-10382-p.jpg)"
]

setup = ->
  flippers = document.getElementById("flippers")
  flippers.style.height = SIZE * height + "px"
  flippers.style.width = SIZE * width + "px"
  y = 0

  while y < height
    x = 0

    while x < width
      tile = document.createElement("div")
      front = document.createElement("div")
      back = document.createElement("div")
      tile.className = "tile"
      tile.id = "tile"
      
      #tile.id = 'tile'+y+'-'+x;
      tile.style.width = SIZE + "px"
      tile.style.height = SIZE + "px"

      $front = $ front
      $front.addClass 'front'
      $front[0].style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px"
      $front[0].style.backgroundImage = imagearray[0]

      $back = $ back
      $back.addClass 'back'
      $back[0].style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px"
      $back[0].style.backgroundImage = imagearray[2]

      $(tile).append($front)
      $(tile).append($back)
      $(flippers).append(tile)

      entity =
        element: tile
        x: x * SIZE
        y: y * SIZE

      tile.style.left = entity.x + "px"
      tile.style.top = entity.y + "px"
      # tile.addEventListener "click", @fliptiles.bind(this, entity)
      # $tile = $ tile

      # $tile.hover $.proxy(liftTile, entity)
      tilearray.push entity
      # tile.style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px"
      # tile.style.backgroundImage = imagearray[0]
      x++
    y++

liftTile = ($event, entity) ->
  targetTile = $($event.target)
  # targetTile.toggleClass 'hovered'
  console.log("entity " + @x + " | " + @y)
  for t in tilearray
    dx = @x - t.x
    dy = @y - t.y
    distance = Math.sqrt(dx * dx + dy * dy)
    if distance < 1
      $(t.element).toggleClass 'hovered'
    if distance < 100 and distance > 1
      $(t.element).toggleClass 'hovered2'
  return

fliptiles = (targetEntity) ->
  background = imagearray[window.i]
  window.i++
  window.i = 0  if window.i is imagearray.length

  for t in tilearray
    $(t.element).addClass('changingBackground').removeClass('hoverable');

  tilearray.forEach (curtile) ->
    dx = targetEntity.x - curtile.x
    dy = targetEntity.y - curtile.y
    distance = Math.sqrt(dx * dx + dy * dy)
    setTimeout (->
      curtile.element.classList.remove  "flip"
      curtile.element.offsetWidth = curtile.element.offsetWidth
      curtile.element.classList.add "flip"
      
      # curtile.element.style.transition = "0s"
      # curtile.element.style.transitionDelay = "0.5s"
      curtile.element.style.backgroundImage = background
      return
    ), Math.round(distance * 2.5)

  setTimeout ( ->
    for t in tilearray
      $(t.element).removeClass('changingBackground').addClass('hoverable');
  ), 700 * 2.5

flip = (request) ->
  fliptiles tilearray[request]

setup()
window.i = 0

# setTimeout (->
#   flip 14
# ), 1000


# updateSlider = ->
#   slider.slider "value", timeline.progress() * 100
#   return
getRandom = (max, min) ->
  Math.floor Math.random() * (1 + max - min) + min
scene = $("#scene")
flippers = $("#flippers")
boxes = $("#flippers .tile")
# slider = $("#slider")
# play_btn = $("#play_btn").button()
timeline = new TimelineLite()
TweenLite.set flippers,
  css:
    transformPerspective: 400
    perspective: 400
    transformStyle: "preserve-3d"

animate = ->
  timeline.fromTo(scene, .5,
    css:
      autoAlpha: 0
  ,
    css:
      autoAlpha: 1

    immediateRender: true
  ).to(flippers, 0.5,
    css:
      rotationY: 30
      rotationX: 20
  )

  timeline.to(flippers, 0.1,
    css:
      className:'+=animated'
    )

  timeline.to(flippers, 0.5,
    css:
      z:-190
  ,
    'z'
    )

  boxes.each (index, element) ->
    timeline.to element, 0.4,
      css:
        z: getRandom(-100, 100)
    , "z"

  timeline
  .to(flippers, 0.5,
    css:
      rotationX: 160
      rotationY: 20
      rotationZ: 180
    transformStyle:"preserve-3d"
    ease: Power2.easeOut
  , "+=0.2")

  boxes.each (index, element) ->
    timeline.to element, 1,
      css:
        z: 0
    , "y"

  timeline.to(flippers, 0.01,
    css:
      className:'-=animated'
  , "y")

  timeline
  .to(flippers, 1,
    css:
      rotationX: 180
      rotationY: 0
      z:0
    ease: Power2.easeOut
  , "y")


  # boxes.each (index, element) ->
  #   timeline.to element, 0,
  #     css:
  #       transform: 'none'
  #   , "x"

  # .to flippers, 0.5,
  #   css:
  #     rotationZ: 180
  #     z: -10
  # $('#flippers').removeClass 'animated'
  return
setTimeout (->
  animate()
  ), 500
  # $('#flippers').removeClass 'animated'
  # boxes.each (index, element) ->
  #   timeline.to element, 1,
  #     css:
  #       z: 200
  #       backgroundColor: Math.random() * 0xffffff
  #       rotationX: getRandom(-360, 600)
  #       rotationY: getRandom(-360, -600)
  #       autoAlpha: 0
  #   , "explode"
  #   return



# $("#slider").slider
#   range: false
#   min: 0
#   max: 100
#   step: .1
#   slide: (event, ui) ->
#     timeline.pause()
#     timeline.progress ui.value / 100
#     return

$("#play_btn").click ->
  animate()
  # timeline.restart()