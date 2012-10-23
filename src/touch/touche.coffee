love = require 'lovejs'
Area = require './area'

class Touche
  constructor: ->
    @areas = []

    love.eventify(this)

  add: (x, y, w, h) ->
    area = new Area(x, y, w, h)
    @areas.push(area)
    area

  activate: (@canvas) ->
    @canvas.addEventListener('touchstart', @start)
    @canvas.addEventListener('touchend', @end)

  deactivate: ->
    @canvas.removeEventListener('touchstart', @start)
    @canvas.removeEventListener('touchend', @end)

  getArea: (touch) ->
    x = touch.pageX
    y = touch.pageY

    for area in @areas
      if area.includes(x, y)
        return area

  start: (e) =>
    touch = e.changedTouches[0]
    area = @getArea(touch)

    if area
      @trigger('touched', area)

    e.preventDefault()
    return

  end: (e) =>
    touch = e.changedTouches[0]
    area = @getArea(touch)

    if area
      @trigger('untouched', area)

    e.preventDefault()
    return

module.exports = Touche
