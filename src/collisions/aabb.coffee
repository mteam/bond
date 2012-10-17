{Vector} = require '../vectors'

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

    aabb.update()

    aabb

  constructor: (x1, y1, x2, y2) ->
    @min = {}
    @max = {}
    @center = new Vector

    @setPosition(x1, y1, x2, y2)

  setPosition: (x1, y1, x2, y2) ->
    @min.x = x1
    @min.y = y1
    @max.x = x2
    @max.y = y2

    @update()

    return

  update: ->
    @center.x = (@min.x + @max.x) / 2
    @center.y = (@min.y + @max.y) / 2

    return

  move: (x, y) ->
    @min.x += x
    @min.y += y
    @max.x += x
    @max.y += y

    @update()

    return

  resolve: (other) ->
    v = new Vector
    u = new Vector

    v.vupdate(other.center).vsubtract(@center)

    if Math.abs(v.x) > Math.abs(v.y)
      if v.x > 0
        u.x = @max.x - other.min.x
      else
        u.x = @min.x - other.max.x
    else
      if v.y > 0
        u.y = @max.y - other.min.y
      else
        u.y = @min.y - other.max.y

    u


module.exports = AABB
