love = require 'lovejs'

class NonlinearAnimation extends love.graphics.Drawable
  constructor: (@reel, @sequence) ->
    @timer = 0
    @frame = 0

  update: (dt) ->
    @timer += dt

    interval = @curr()[1]

    if @timer > interval
      @timer -= interval
      @nextFrame()

  nextFrame: ->
    @frame++
    if @frame >= @sequence.length
      @frame = 0
      @end()

  curr: ->
    @sequence[@frame]

  rewind: ->
    @frame = 0
    @timer = 0

  end: ->

  draw: (ctx, x, y) ->
    quad = @reel.getQuad(@curr()[0])
    love.graphics.drawq(@reel.image, quad, x, y)

module.exports = NonlinearAnimation
