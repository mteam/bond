AABB = require './aabb'
vectors = require '../vectors'

class Collider
  constructor: ->
    @aabb = new AABB(0, 0, 0, 0)

    @step = new vectors.Vector
    @nstep = new vectors.Vector

    @frozen = false
    @moving = true

    @object = null
    @tags = []

  getPos: ->
    @aabb.min

  setPos: (x, y) ->
    @aabb.moveTo(x, y)

  setDim: (w, h) ->
    @aabb.resize(w, h)

  stop: ->
    @step.reset()
    @moving = false

  getObject: ->
    @object

  setObject: (object) ->
    @object = object

  addTag: ->
    for tag in arguments
      @tags.push(tag)
    return

  hasTag: (tag) ->
    tag in @tags

  freeze: ->
    @frozen = true

  unfreeze: ->
    @frozen = false

  update: (x, y) ->
    @step.update(x, y)
    @nstep.vupdate(@step).normalize()
    @moving = true

  collision: ->

module.exports = Collider
