love = require 'lovejs'

class TileLayer
  type: 'tile'

  @create: (json, map) ->
    layer = new TileLayer
    layer.name = json.name
    layer.width = map.width
    layer.height = map.height
    layer.grid = []

    # create grid
    i = 0
    for y in [0...json.height]
      layer.grid.push(row = [])
      for x in [0...json.width]
        id = json.data[i++]

        if id is 0
          continue

        if not map.tiles[id]?
          throw new Error("Tile #{id} does not exist");

        row.push
          x: x * map.json.tilewidth
          y: y * map.json.tileheight
          tile: map.tiles[id]

    layer
      
  draw: ->
    canvas = love.graphics.newCanvas(@width, @height)

    for row in @grid
      for cell in row
        cell.tile.draw(canvas, cell.x, cell.y)

    canvas

module.exports = TileLayer
