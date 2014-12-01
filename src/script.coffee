height = 5
width = 5
SIZE = 100
deg = 0
tilearray = []
imagearray = [
  "url(./img/FY7A4025-Edit-Edit.jpg)",
  "url(http://s5.favim.com/orig/51/apple-steve-jobs-black-and-white-face-Favim.com-465544.jpg)",
  "url(./img/cat-fliped.jpg)"
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
back = $("#flippers .back")
# slider = $("#slider")
# play_btn = $("#play_btn").button()
timeline = new TimelineLite()
TweenLite.set flippers,
  css:
    transformPerspective: 400
    perspective: 400
    transformStyle: "preserve-3d"

animate = ->

  back.each (index, element) ->
    timeline.to element, 0.01,
      css:
        rotationY:-180
    , 'start'

  timeline.to flippers, 0.1,
    css:
      rotationY:0
      rotationX:0
      rotationZ:0
  , 'start'

  timeline.fromTo scene, .5,
    css:
      autoAlpha: 0
  ,
    css:
      autoAlpha: 1

    immediateRender: true
  , 'fadeIn'

  timeline.to flippers, 0.5,
    css:
      rotationY: 30
      rotationX: 20
      z: -100
  , "fadeIn+=0.25"

  timeline.to flippers, 0.01,
    css:
      className: '+=animated'
  , "h"

  boxes.each (index, element) ->
    timeline.to element, 0.5,
      css:
        z: getRandom(-70, 70)
    , "o"

  timeline.to flippers, 0.8,
    css:
      rotationX: -160
      # rotationY: 0
      # rotationZ: 180
  , "rotate"

  back.each (index, element) ->
    timeline.to element, 0.8,
      css:
        rotationY: 0
    , "rotate"

  boxes.each (index, element) ->
    timeline.to element, 0.3,
      css:
        z: 0
    , 'rotate+=0.5'

  # timeline.to flippers, 0.3,
  #   css:
  # , "rotate+=0.5"

  timeline.to flippers, 0.5,
    css:
      rotationY: 0
      rotationX: -180
      z:0
      className:'-=animated'
  , "flatten"


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

$("#reverse_btn").click ->
  timeline.reverse()

$("#pause_btn").click ->
  timeline.pause()

$("#restart_btn").click ->
  timeline.restart('z')

$("#play_btn").click ->
  timeline.play()
