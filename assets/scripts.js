var SIZE, deg, flip, fliptiles, height, imagearray, liftTile, setup, tilearray, width;

height = 10;

width = 10;

SIZE = 50;

deg = 0;

tilearray = [];

imagearray = ["url(http://indulgy.ccio.co/NB/88/JE/0fd57ce1955a2bf5f2060c83bbd9bfac.jpg)", "url(http://s5.favim.com/orig/51/apple-steve-jobs-black-and-white-face-Favim.com-465544.jpg)", "url(http://www.creoglassonline.co.uk/ekmps/shops/bohdan/images/black-cat-face-[2]-10382-p.jpg)"];

setup = function() {
  var $tile, entity, flippers, tile, x, y, _results;
  flippers = document.getElementById("flippers");
  flippers.style.height = SIZE * height + "px";
  flippers.style.width = SIZE * width + "px";
  y = 0;
  _results = [];
  while (y < height) {
    x = 0;
    while (x < width) {
      tile = document.createElement("div");
      tile.className = "tile";
      tile.id = "tile";
      tile.style.width = SIZE + "px";
      tile.style.height = SIZE + "px";
      flippers.appendChild(tile);
      entity = {
        element: tile,
        x: x * SIZE,
        y: y * SIZE
      };
      tile.style.left = entity.x + "px";
      tile.style.top = entity.y + "px";
      tile.addEventListener("click", this.fliptiles.bind(this, entity));
      $tile = $(tile);
      $tile.hover($.proxy(liftTile, entity));
      tilearray.push(entity);
      tile.style.backgroundPosition = "-" + x * SIZE + "px -" + y * SIZE + "px";
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

setTimeout((function() {
  return flip(44);
}), 1000);
