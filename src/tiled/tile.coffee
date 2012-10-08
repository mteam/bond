class Tile
  @createFromTileset: (ts, images) ->
    cols = ts.imagewidth / ts.tilewidth
    rows = ts.imageheight / ts.tileheight
    image = images[ts.name]
    id = ts.firstgid

    tiles = []

    for row in [0...rows]
      for col in [0...cols]
        tiles.push(tile = new Tile)
        tile.id = id++
        tile.x = col * ts.tilewidth
        tile.y = row * ts.tileheight
        tile.width = ts.tilewidth
        tile.height = ts.tileheight
        tile.image = image

    tiles

  draw: (canvas, x, y) ->
    canvas.ctx.drawImage(@image, @x, @y, @width, @height, x, y, @width, @height)

module.exports = Tile
