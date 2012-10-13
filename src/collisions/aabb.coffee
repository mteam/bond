class AABB
  @overlaps: (a, b) ->
    not (
      a.min.x > b.max.x or
      a.min.y > b.max.y or
      a.max.x < b.min.x or
      a.max.y < b.min.y
    )

  constructor: (x1, y1, x2, y2) ->
    @min = {}
    @max = {}
    @update(x1, y1, x2, y2)

  update: (x1, y1, x2, y2) ->
    @min.x = x1
    @min.y = y1
    @max.x = x2
    @max.y = y2

module.exports = AABB
