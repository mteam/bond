{Vector} = require '../vectors'

round = (n) ->
  Math.round(n * 1000) / 1000

class AABB
  @collides: (a, b) ->
    not (
      a.min.x > b.max.x or
      a.min.y > b.max.y or
      a.max.x < b.min.x or
      a.max.y < b.min.y
    )

  @overlap: (a, b) ->
    if not @collides(a, b)
      return null

    aabb = new AABB

    aabb.min.x = Math.max(a.min.x, b.min.x)
    aabb.min.y = Math.max(a.min.y, b.min.y)
    aabb.max.x = Math.min(a.max.x, b.max.x)
    aabb.max.y = Math.min(a.max.y, b.max.y)

    aabb

  constructor: (x1, y1, x2, y2) ->
    @min = {}
    @max = {}

    @update(x1, y1, x2, y2)

  update: (x1, y1, x2, y2) ->
    @min.x = x1
    @min.y = y1
    @max.x = x2
    @max.y = y2

    return

  move: (x, y) ->
    @min.x = round(@min.x + x)
    @min.y = round(@min.y + y)
    @max.x = round(@max.x + x)
    @max.y = round(@max.y + y)

    return

  moveTo: (x, y) ->
    right = x - @min.x
    down = y - @min.y

    @move(right, down)

    return

  resize: (w, h) ->
    @max.x = @min.x + w
    @max.y = @min.y + h

    return

  resolve: (other) ->
    v = new Vector
    a = this
    b = other

    left = b.max.x - a.min.x
    right = a.max.x - b.min.x
    up = b.max.y - a.min.y
    down = a.max.y - b.min.y

    if left < right
      v.x = -1 * left
    else
      v.x = right

    if up < down
      v.y = -1 * up
    else
      v.y = down

    if Math.abs(v.x) > Math.abs(v.y)
      v.x = 0
    else
      v.y = 0

    v

  distanceTo: (other, dist = {}) ->
    dist.x = ((other.min.x + other.max.x) - (@min.x + @max.x)) / 2
    dist.y = ((other.min.y + other.max.y) - (@min.y + @max.y)) / 2
    dist

  includes: (x, y) ->
    not (
      @min.x > x or
      @min.y > y or
      @max.x < x or
      @max.y < y
    )

  getWidth: ->
    @max.x - @min.x

  getHeight: ->
    @max.y - @min.y


module.exports = AABB
