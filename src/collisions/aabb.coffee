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

  move: (x, y) ->
    @min.x += x
    @min.y += y
    @max.x += x
    @max.y += y

module.exports = AABB
