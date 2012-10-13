class SpatialHash
  constructor: (@cellSize) ->
    @hash = {}

  reset: ->
    for coords, cell of @hash
      cell.length = 0
    return

  insert: (aabb, obj) ->
    x1 = @coord(aabb.min.x)
    y1 = @coord(aabb.min.y)

    # max coordinates are subtracted by 1, so that when they are in the
    # right bottom corner of a cell, they don't overflow.
    # just think about it.
    # when the max coordinates are 100x100 and the cell size is 50, @coord(100)
    # would return 2, but the max point of AABB belongs to cell 1x1, not 2x2.
    x2 = @coord(aabb.max.x - 1)
    y2 = @coord(aabb.max.y - 1)

    for x in [x1..x2]
      for y in [y1..y2]
        @cell(x, y).push(obj)

    return

  collisions: (aabb, obj) ->

  cell: (x, y) ->
    @hash["#{x}x#{y}"] ?= []

  coord: (x) ->
    (x / @cellSize) | 0

module.exports = SpatialHash
