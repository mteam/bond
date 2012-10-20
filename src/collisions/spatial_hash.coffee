AABB = require './aabb'

isValid = (obj) ->
  obj.aabb? and obj.aabb instanceof AABB

class SpatialHash
  constructor: (@cellSize) ->
    @hash = {}

    @_coords = x1: null, y1: null, x2: null, y2: null

  reset: ->
    for coords, cell of @hash
      cell.length = 0
    return

  insert: (obj) ->
    if not isValid(obj)
      throw new Error("Object '#{obj}' couldn't be inserted in spatial hash")

    {x1, y1, x2, y2} = @coords(obj.aabb)

    for x in [x1..x2]
      for y in [y1..y2]
        @cell(x, y).push(obj)

    return

  collisions: (obj) ->
    if not isValid(obj)
      throw new Error("Couldn't check collisions for object '#{obj}'")

    set = []
    {x1, y1, x2, y2} = @coords(obj.aabb)

    for x in [x1..x2]
      for y in [y1..y2]
        for other in @cell(x, y)
          if (
            other isnt obj and
            other not in set and
            AABB.collides(other.aabb, obj.aabb)
          )
            set.push(other)

    set

  cell: (x, y) ->
    @hash["#{x}x#{y}"] ?= []

  coords: (aabb) ->
    @_coords.x1 = @coord(aabb.min.x)
    @_coords.y1 = @coord(aabb.min.y)

    # max coordinates are subtracted by 1, so that when they are in the
    # right bottom corner of a cell, they don't overflow.
    # just think about it.
    # when the max coordinates are 100x100 and the cell size is 50, @coord(100)
    # would return 2, but the max point of AABB belongs to cell 1x1, not 2x2.
    @_coords.x2 = @coord(aabb.max.x - 1)
    @_coords.y2 = @coord(aabb.max.y - 1)

    @_coords

  coord: (x) ->
    (x / @cellSize) | 0

module.exports = SpatialHash
