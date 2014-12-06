scene = document.getElementById 'scene'
parallax = new Parallax scene

(->
       
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

  initHeader = ->
    # width = window.innerWidth
    # height = window.innerHeight
    width = 500
    height = 500
    target =
      x: 0
      y: height

    # largeHeader = document.getElementById("large-header")
    # largeHeader.style.height = height + "px"
    canvas = document.getElementById("demo-canvas")
    canvas.width = width
    canvas.height = height
    ctx = canvas.getContext("2d")
    
    # create particles
    circles = []
    x = 0

    while x < width * 0.04
      c = new Circle()
      circles.push c
      x++
    animate()
  
  # Event handling
  addListeners = ->
    window.addEventListener "scroll", scrollCheck
    # window.addEventListener "resize", resize

  scrollCheck = ->
    if document.body.scrollTop > height
      animateHeader = false
    else
      animateHeader = true

  resize = ->
    width = window.innerWidth
    height = window.innerHeight
    # largeHeader.style.height = height + "px"
    canvas.width = width
    canvas.height = height

  firstRun = true
  animate = ->
    if animateHeader
      ctx.clearRect 0, 0, width, height
      if firstRun
        for i of circles
          ((i)->
            setTimeout (->
              circles[i].draw()
              ), 120 * i
            )(i)
        setTimeout (->
            firstRun = false
          ), circles.length * 120
      else
        for i of circles
          circles[i].draw()
    requestAnimationFrame animate
  
  class Circle
    constructor: ->
      @pos = {}
      @init()
      console.log @

    init: ->
      @pos.x = getRandom(100, width - 100)
      @pos.y = getRandom(200, height)
      # @pos.x = Math.random() * width
      # @pos.y = height + Math.random() * 300
      @alpha = 0.1 + Math.random() * 0.9
      @scale = 0.1 + Math.random() * 0.05
      @life = 20+Math.random()*10;
      @remaining_life = @life;
      @speed = 
        x: -2.5+Math.random() * 5
        y: -5 + Math.random()

    draw: ->
      @scale -= 0.00065
      @alpha -= 0.005
      @remaining_life -= 0.1
      @init()  if @remaining_life < 0 or @scale < 0
      @pos.y += @speed.y
      @pos.x += @speed.x
      ctx.beginPath()
      ctx.arc @pos.x, @pos.y, @scale * 10, 0, 2 * Math.PI, false
      ctx.fillStyle = "rgba(254,149,0," + @alpha + ")"
      ctx.fill()

  initHeader()
  addListeners()
)()