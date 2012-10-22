Container = require './container'

class LovedContainer extends Container
  init: ->
    c.init?() for name, c of @_cs
    return

  update: (dt) ->
    c.update?(dt) for name, c of @_cs
    return

  draw: ->
    c.draw?() for name, c of @_cs
    return

module.exports = LovedContainer
