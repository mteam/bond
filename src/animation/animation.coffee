love = require 'lovejs'
Reel = require './reel'

class Animation extends love.graphics.Drawable
  constructor: (@reel, @interval, @sequence) ->
    @timer = 0
    @frame = 0

  update: (dt) ->
    @timer += dt

    if (@timer > @interval)
      @timer -= @interval
      @nextFrame()

  nextFrame: ->
    @frame++
    if @frame >= @sequence.length
      @frame = 0

  draw: (ctx, x, y) ->
    quad = @reel.getQuad(@sequence[@frame])
    love.graphics.drawq(@reel.image, quad, x, y)

module.exports = Animation
