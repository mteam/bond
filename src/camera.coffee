love = require 'lovejs'
AABB = require './collisions/aabb'

class Camera
  constructor: (width, height) ->
    canvas = love.graphics.getCanvas()
    width ?= canvas.width
    height ?= canvas.height

    @aabb = new AABB(0, 0, width, height)

  lookAt: (x, y) ->
    @aabb.moveTo(
      x - (@aabb.getWidth() / 2),
      y - (@aabb.getHeight() / 2)
    )

  getOffset: ->
    @aabb.min

  translate: ->
    offset = @getOffset()

    love.graphics.push()
    love.graphics.translate(-1 * offset.x, -1 * offset.y)

  restore: ->
    love.graphics.pop()

module.exports = Camera
