height = 10
width = 10
SIZE = 50
deg = 0
tilearray = []
imagearray = [
  "url(http://indulgy.ccio.co/NB/88/JE/0fd57ce1955a2bf5f2060c83bbd9bfac.jpg)"
  "url(http://s5.favim.com/orig/51/apple-steve-jobs-black-and-white-face-Favim.com-465544.jpg)"
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
      tile.className = "tile"
      tile.id = "tile"
      
      #tile.id = 'tile'+y+'-'+x;
      tile.style.width = SIZE + "px"
      tile.style.height = SIZE + "px"
      flippers.appendChild tile
      entity =
        element: tile
        x: x * SIZE
        y: y * SIZE

      tile.style.left = entity.x + "px"
      tile.style.top = entity.y + "px"
      tile.addEventListener "click", @fliptiles.bind(this, entity)
      $tile = $ tile
      $tile.hover $.proxy(liftTile, entity)
      # $tile.attr('data-x', entity.x)
      # $tile.attr('data-y', entity.y)

      tilearray.push entity
      tile.style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px"
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
  # tile = (t for t in tilearray when t.x is targetEntity.x and t.y is targetEntity.y)

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

setTimeout (->
  flip 44
), 1000