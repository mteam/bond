love = require 'lovejs'

class Reel
  constructor: (@image, @width, @height) ->
    cols = (@image.width / @width) | 0
    rows = (@image.height / @height) | 0

    @quads = []

    for y in [0...rows]
      for x in [0...cols]
        quad = love.graphics.newQuad(x * @width, y * @height, @width, @height)
        @quads.push(quad)

  getQuad: (i) ->
    @quads[i - 1]

module.exports = Reel
