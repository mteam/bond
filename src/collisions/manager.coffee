SpatialHash = require './spatial_hash'
Collider = require './collider'

class Manager
  constructor: (@max) ->
    @max2 = @max * @max
    @hash = new SpatialHash(@max * 2)
    @colliders = []

  add: (collider) ->
    if collider not instanceof Collider
      throw new Error("#{collider} is not a collider")

    @colliders.push(collider)

    return

  remove: (collider) ->
    index = @colliders.indexOf(collider)

    if index > -1
      @colliders.splice(index, 1)

  update: ->
    for c in @colliders when not c.frozen
      c.nstep.multiply(@max)
      c.moving = true

    moved = true

    while moved
      moved = false

      for c, i in @colliders when c.moving and not c.frozen
        len2 = c.step.length2()

        if len2 <= @max2
          c.aabb.move(c.step.x, c.step.y)
          c.step.reset()
        else
          c.aabb.move(c.nstep.x, c.nstep.y)
          c.step.vsubtract(c.nstep)

        moved = true

      if moved
        @rebuild()
        @trigger()

      for c in @colliders when c.moving and not c.frozen
        if c.step.length2() is 0
          c.stop()

    return

  rebuild: ->
    @hash.reset()

    for c in @colliders
      @hash.insert(c)

    return

  trigger: ->
    for i in [@colliders.length-1..0] by -1
      collider = @colliders[i]

      if not collider.moving or collider.frozen
        continue
      
      for col in @hash.collisions(collider)
        collider.collision(col)

    return

module.exports = Manager
