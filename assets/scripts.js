var Circle, addCircles, addListeners, animate, animateHeader, canvas, circles, ctx, firstRun, getRandom, height, initHeader, largeHeader, onMouseOver, parallax, resize, scene, scrollCheck, target, width, x;

scene = document.getElementById('scene');

parallax = new Parallax(scene);

width = void 0;

height = void 0;

largeHeader = void 0;

canvas = void 0;

ctx = void 0;

circles = void 0;

target = void 0;

animateHeader = true;

getRandom = function(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

x = 0;

initHeader = function() {
  width = 300;
  height = 500;
  target = {
    x: 0,
    y: height
  };
  canvas = document.getElementById("demo-canvas");
  canvas.width = width;
  canvas.height = height;
  canvas.addEventListener("mouseover", onMouseOver);
  ctx = canvas.getContext("2d");
  circles = {};
  addCircles();
  return animate();
};

addListeners = function() {
  return window.addEventListener("scroll", scrollCheck);
};

scrollCheck = function() {
  if (document.body.scrollTop > height) {
    return animateHeader = false;
  } else {
    return animateHeader = true;
  }
};

resize = function() {
  width = window.innerWidth;
  height = window.innerHeight;
  canvas.width = width;
  return canvas.height = height;
};

addCircles = function() {
  var c, count, _results;
  count = 0;
  _results = [];
  while (count < width * 0.09) {
    c = new Circle(x);
    circles[x] = c;
    x++;
    _results.push(count++);
  }
  return _results;
};

onMouseOver = function() {
  return addCircles();
};

firstRun = true;

animate = function() {
  var circle, i;
  if (animateHeader) {
    ctx.clearRect(0, 0, width, height);
    for (i in circles) {
      circle = circles[i];
      circle.draw();
    }
  }
  return requestAnimationFrame(animate);
};

Circle = (function() {
  function Circle(id) {
    this.id = id;
    this.pos = {};
    this.init();
  }

  Circle.prototype.init = function() {
    this.pos.x = getRandom(0, width);
    this.pos.y = getRandom(200, height);
    this.alpha = 0.1 + Math.random() * 0.9;
    this.scale = 0.1 + Math.random() * 0.05;
    this.life = 20 + Math.random() * 10;
    this.remaining_life = this.life;
    return this.speed = {
      x: -2.5 + Math.random() * 5,
      y: -5 + Math.random()
    };
  };

  Circle.prototype.draw = function() {
    this.scale -= 0.00065;
    this.alpha -= 0.005;
    this.remaining_life -= 0.1;
    if (this.remaining_life < 0 || this.scale < 0) {
      delete circles[this.id];
      return;
    }
    this.pos.y += this.speed.y;
    this.pos.x += this.speed.x;
    ctx.beginPath();
    ctx.arc(this.pos.x, this.pos.y, this.scale * 10, 0, 2 * Math.PI, false);
    ctx.fillStyle = "rgba(254,149,0," + this.alpha + ")";
    return ctx.fill();
  };

  return Circle;

})();

initHeader();

addListeners();
