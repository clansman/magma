scene = document.getElementById 'scene'
parallax = new Parallax scene

width = undefined
height = undefined
largeHeader = undefined
canvas = undefined
ctx = undefined
circles = undefined
target = undefined
animateHeader = true

getRandom = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min

x = 0
initHeader = ->
  width = 300
  height = 500
  target =
    x: 0
    y: height

  canvas = document.getElementById("demo-canvas")
  canvas.width = width
  canvas.height = height
  canvas.addEventListener "mouseover", onMouseOver
  ctx = canvas.getContext("2d")

  circles = {}

  addCircles()
  animate()

resize = ->
  width = window.innerWidth
  height = window.innerHeight
  canvas.width = width
  canvas.height = height


addCircles = ->
  count = 0
  while count < width * 0.09
    c = new Circle(x)
    circles[x] = c
    x++
    count++

onMouseOver =  ->
  addCircles()

firstRun = true
animate = ->
  if animateHeader
    ctx.clearRect 0, 0, width, height
    for i, circle of circles
      circle.draw()
  requestAnimationFrame animate

class Circle
  constructor: (@id) ->
    @pos = {}
    @init()

  init: ->
    @pos.x = getRandom(0, width)
    @pos.y = getRandom(200, height)
    @alpha = 0.1 + Math.random() * 0.9
    @scale = 0.1 + Math.random() * 0.05
    @life = 20+Math.random()*10
    @remaining_life = @life
    @speed =
      x: -2.5+Math.random() * 5
      y: -5 + Math.random()

  draw: ->
    @scale -= 0.00065
    @alpha -= 0.005
    @remaining_life -= 0.1
    if @remaining_life < 0 or @scale < 0
      delete circles[@id]
      return
    @pos.y += @speed.y
    @pos.x += @speed.x
    ctx.beginPath()
    ctx.arc @pos.x, @pos.y, @scale * 10, 0, 2 * Math.PI, false
    ctx.fillStyle = "rgba(254,149,0," + @alpha + ")"
    ctx.fill()

initHeader()
addListeners()