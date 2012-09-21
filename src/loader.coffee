love = require 'lovejs'
gamestate = require './gamestate'

class Loader extends gamestate.Gamestate
  init: ->
    @text = x: 0, y: 0

  enter: (cb) ->
    love.graphics.push()

    love.graphics.setFont('Arial', 20)
    love.graphics.setTextAlign('center')
    love.graphics.setTextBaseline('middle')

    canvas = love.graphics.getCanvas()
    @text.x = canvas.width / 2
    @text.y = canvas.height / 2

    love.assets.load ->
      setTimeout(cb, 300)

  draw: ->
    progress = love.assets.getProgress()
    love.graphics.print("Loading... (#{progress.loaded}/#{progress.total})", @text.x, @text.y)

  leave: ->
    love.graphics.pop()

module.exports = Loader
