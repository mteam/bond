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

  fix: (x1, y1, x2, y2) ->
    if @aabb.min.x < x1
      @aabb.move(-1 * (@aabb.min.x - x1), 0)
    else if @aabb.max.x > x2
      @aabb.move(-1 * (@aabb.max.x - x2), 0)

    if @aabb.min.y < y1
      @aabb.move(0, -1 * (@aabb.min.y - y1))
    else if @aabb.max.y > y2
      @aabb.move(0, -1 * (@aabb.max.y - y2))

  getOffset: ->
    @aabb.min

  translate: ->
    offset = @getOffset()

    love.graphics.push()
    love.graphics.translate(-1 * offset.x, -1 * offset.y)

  restore: ->
    love.graphics.pop()

module.exports = Camera
