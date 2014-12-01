var SIZE, animate, back, boxes, deg, flip, flippers, fliptiles, getRandom, height, imagearray, liftTile, scene, setup, tilearray, timeline, width;

height = 5;

width = 5;

SIZE = 100;

deg = 0;

tilearray = [];

imagearray = ["url(../img/FY7A4025-Edit-Edit.jpg)", "url(http://s5.favim.com/orig/51/apple-steve-jobs-black-and-white-face-Favim.com-465544.jpg)", "url(../img/cat-fliped.jpg)"];

setup = function() {
  var $back, $front, back, entity, flippers, front, tile, x, y, _results;
  flippers = document.getElementById("flippers");
  flippers.style.height = SIZE * height + "px";
  flippers.style.width = SIZE * width + "px";
  y = 0;
  _results = [];
  while (y < height) {
    x = 0;
    while (x < width) {
      tile = document.createElement("div");
      front = document.createElement("div");
      back = document.createElement("div");
      tile.className = "tile";
      tile.id = "tile";
      tile.style.width = SIZE + "px";
      tile.style.height = SIZE + "px";
      $front = $(front);
      $front.addClass('front');
      $front[0].style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px";
      $front[0].style.backgroundImage = imagearray[0];
      $back = $(back);
      $back.addClass('back');
      $back[0].style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px";
      $back[0].style.backgroundImage = imagearray[2];
      $(tile).append($front);
      $(tile).append($back);
      $(flippers).append(tile);
      entity = {
        element: tile,
        x: x * SIZE,
        y: y * SIZE
      };
      tile.style.left = entity.x + "px";
      tile.style.top = entity.y + "px";
      tilearray.push(entity);
      x++;
    }
    _results.push(y++);
  }
  return _results;
};

liftTile = function($event, entity) {
  var distance, dx, dy, t, targetTile, _i, _len;
  targetTile = $($event.target);
  console.log("entity " + this.x + " | " + this.y);
  for (_i = 0, _len = tilearray.length; _i < _len; _i++) {
    t = tilearray[_i];
    dx = this.x - t.x;
    dy = this.y - t.y;
    distance = Math.sqrt(dx * dx + dy * dy);
    if (distance < 1) {
      $(t.element).toggleClass('hovered');
    }
    if (distance < 100 && distance > 1) {
      $(t.element).toggleClass('hovered2');
    }
  }
};

fliptiles = function(targetEntity) {
  var background, t, _i, _len;
  background = imagearray[window.i];
  window.i++;
  if (window.i === imagearray.length) {
    window.i = 0;
  }
  for (_i = 0, _len = tilearray.length; _i < _len; _i++) {
    t = tilearray[_i];
    $(t.element).addClass('changingBackground').removeClass('hoverable');
  }
  tilearray.forEach(function(curtile) {
    var distance, dx, dy;
    dx = targetEntity.x - curtile.x;
    dy = targetEntity.y - curtile.y;
    distance = Math.sqrt(dx * dx + dy * dy);
    return setTimeout((function() {
      curtile.element.classList.remove("flip");
      curtile.element.offsetWidth = curtile.element.offsetWidth;
      curtile.element.classList.add("flip");
      curtile.element.style.backgroundImage = background;
    }), Math.round(distance * 2.5));
  });
  return setTimeout((function() {
    var _j, _len1, _results;
    _results = [];
    for (_j = 0, _len1 = tilearray.length; _j < _len1; _j++) {
      t = tilearray[_j];
      _results.push($(t.element).removeClass('changingBackground').addClass('hoverable'));
    }
    return _results;
  }), 700 * 2.5);
};

flip = function(request) {
  return fliptiles(tilearray[request]);
};

setup();

window.i = 0;

getRandom = function(max, min) {
  return Math.floor(Math.random() * (1 + max - min) + min);
};

scene = $("#scene");

flippers = $("#flippers");

boxes = $("#flippers .tile");

back = $("#flippers .back");

timeline = new TimelineLite();

TweenLite.set(flippers, {
  css: {
    transformPerspective: 400,
    perspective: 400,
    transformStyle: "preserve-3d"
  }
});

animate = function() {
  back.each(function(index, element) {
    return timeline.to(element, 0.01, {
      css: {
        rotationY: -180
      }
    }, 'start');
  });
  timeline.to(flippers, 0.1, {
    css: {
      rotationY: 0,
      rotationX: 0,
      rotationZ: 0
    }
  }, 'start');
  timeline.fromTo(scene, .5, {
    css: {
      autoAlpha: 0
    }
  }, {
    css: {
      autoAlpha: 1
    },
    immediateRender: true
  }, 'fadeIn');
  timeline.to(flippers, 0.5, {
    css: {
      rotationY: 30,
      rotationX: 20,
      z: -100
    }
  }, "fadeIn+=0.25");
  timeline.to(flippers, 0.01, {
    css: {
      className: '+=animated'
    }
  }, "h");
  boxes.each(function(index, element) {
    return timeline.to(element, 0.5, {
      css: {
        z: getRandom(-70, 70)
      }
    }, "o");
  });
  timeline.to(flippers, 0.8, {
    css: {
      rotationX: -160
    }
  }, "rotate");
  back.each(function(index, element) {
    return timeline.to(element, 0.8, {
      css: {
        rotationY: 0
      }
    }, "rotate");
  });
  boxes.each(function(index, element) {
    return timeline.to(element, 0.3, {
      css: {
        z: 0
      }
    }, 'rotate+=0.5');
  });
  return timeline.to(flippers, 0.5, {
    css: {
      rotationY: 0,
      rotationX: -180,
      z: 0,
      className: '-=animated'
    }
  }, "flatten");
};

setTimeout((function() {
  return animate();
}), 500);

$("#reverse_btn").click(function() {
  return timeline.reverse();
});

$("#pause_btn").click(function() {
  return timeline.pause();
});

$("#restart_btn").click(function() {
  return timeline.restart('z');
});

$("#play_btn").click(function() {
  return timeline.play();
});
