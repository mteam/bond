class Vector
  constructor: (x = 0, y = 0) ->
    @update(x, y)
  
  reset: ->
    @update(0, 0)

  clone: ->
    new Vector(@x, @y)

  update: (@x, @y) ->
    this

  vupdate: ({@x, @y}) ->
    this

  add: (x, y) ->
    @x += x
    @y += y
    this

  vadd: ({x, y}) ->
    @add(x, y)
    this

  subtract: (x, y) ->
    @x -= x
    @y -= y
    this

  vsubtract: ({x, y}) ->
    @subtract(x, y)
    this

  multiply: (n) ->
    @x *= n
    @y *= n
    this

  divide: (n) ->
    @x /= n
    @y /= n
    this

  length2: ->
    @x * @x + @y * @y

  length: ->
    Math.sqrt(@length2())

  normalize: ->
    @divide(@length())

exports.Vector = Vector
