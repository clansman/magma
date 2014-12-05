var parallax, scene;

scene = document.getElementById('scene');

parallax = new Parallax(scene);

(function() {
  var Circle, addListeners, animate, animateHeader, canvas, circles, ctx, height, initHeader, largeHeader, resize, scrollCheck, target, width;
  width = void 0;
  height = void 0;
  largeHeader = void 0;
  canvas = void 0;
  ctx = void 0;
  circles = void 0;
  target = void 0;
  animateHeader = true;
  initHeader = function() {
    var c, x;
    width = 500;
    height = 200;
    target = {
      x: 0,
      y: height
    };
    canvas = document.getElementById("demo-canvas");
    canvas.width = width;
    canvas.height = height;
    ctx = canvas.getContext("2d");
    circles = [];
    x = 0;
    while (x < width * 0.07) {
      c = new Circle();
      circles.push(c);
      x++;
    }
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
  animate = function() {
    var i;
    if (animateHeader) {
      ctx.clearRect(0, 0, width, height);
      for (i in circles) {
        circles[i].draw();
      }
    }
    return requestAnimationFrame(animate);
  };
  Circle = (function() {
    function Circle() {
      this.pos = {};
      this.init();
      console.log(this);
    }

    Circle.prototype.init = function() {
      this.pos.x = Math.random() * width;
      this.pos.y = height + Math.random() * 500;
      this.alpha = 0.1 + Math.random() * 0.3;
      this.scale = 0.1 + Math.random() * 0.05;
      this.velocity = Math.random() * 10;
      this.life = 20 + Math.random() * 10;
      this.remaining_life = this.life;
      return this.speed = {
        x: -2.5 + Math.random() * 5,
        y: -4 + Math.random()
      };
    };

    Circle.prototype.draw = function() {
      this.scale -= 0.00065;
      this.alpha -= 0.0015;
      this.remaining_life -= 0.1;
      if (this.remaining_life < 0 || this.scale < 0) {
        this.init();
      }
      this.pos.y += this.speed.y;
      this.pos.x += this.speed.x;
      ctx.beginPath();
      ctx.arc(this.pos.x, this.pos.y, this.scale * 10, 0, 2 * Math.PI, false);
      ctx.fillStyle = "rgba(254,149,0," + 0.8 + ")";
      return ctx.fill();
    };

    return Circle;

  })();
  initHeader();
  return addListeners();
})();
