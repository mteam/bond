class Area
  constructor: (x, y, w, h) ->
    @min = {x, y}
    @max = {x: x + w, y: y + h}

  includes: (x, y) ->
    not (
      x < @min.x or
      x > @max.x or
      y < @min.y or
      y > @max.y
    )

module.exports = Area
