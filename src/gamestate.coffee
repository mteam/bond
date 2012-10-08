love = require 'lovejs'

$current = null
$instances = {}

exports.switch = (state, args...) ->
  if not state.instance?
    state.instance = new state

  love.timer.nextTick ->
    $current?.leave?()
    $current = state.instance
    $current.enter?(args...)

callbacks = [
  'update', 'draw', 'keypressed', 'keyreleased',
  'mousepressed', 'mousereleased'
]

for name in callbacks
  do (name) ->
    exports[name] = ->
      $current[name]?(arguments...)

exports.register = ->
  for name in callbacks
    love[name] ?= exports[name]



class exports.Gamestate
  @assets: (assets) ->
    love.assets.add(asset for name, asset of assets)

    @_assets ?= {}

    for name, asset of assets
      @_assets[name] = asset.getContent()

  @image: (url) ->
    love.assets.newImage(url)

  @switch: (args...) ->
    exports.switch(this, args...)

  constructor: ->
    if @constructor._assets?
      @assets = {}
      for name, asset of @constructor._assets
        @assets[name] = asset

    @init?()
