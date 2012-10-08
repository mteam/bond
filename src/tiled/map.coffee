Tile = require './tile'
TileLayer = require './tile_layer'
ObjectLayer = require './object_layer'

class Map
  @create: (json, images) ->
    map = new Map
    map.json = json
    map.width = json.width * json.tilewidth
    map.height = json.height * json.tileheight
    map.tiles = []
    map.layers = []

    for tileset in json.tilesets
      for tile in Tile.createFromTileset(tileset, images)
        map.tiles[tile.id] = tile

    for layer in json.layers
      cls = switch layer.type
        when 'tilelayer' then TileLayer
        when 'objectgroup' then ObjectLayer

      map.layers.push(cls.create(layer, map))

    map

  layer: (name) ->
    for layer in @layers
      return layer if layer.name is name

module.exports = Map
  