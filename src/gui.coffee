love = require 'lovejs'
gui = exports

$container = null

gui.setContainer = (el) ->
  $container = new Container(el)

gui.add = (widget) ->
  $container.add(widget)

gui.remove = (widget) ->
  $container.remove(widget)

gui.clear = ->
  $container.clear()

gui.newButton = (text, x, y, cls) ->
  new Button(text, x, y, cls)



class Container
  constructor: (@el) ->
    @widgets = []

  add: (widget) ->
    if widget.getElement?
      @el.appendChild(widget.getElement())
      @widgets.push(widget)
    else
      throw new Error("this isn't a widget")

  remove: (widget) ->
    if widget.getElement?
      @el.removeChild(widget.getElement())
    else
      throw new Error("this isn't a widget")

  clear: ->
    for widget in @widgets
      @remove(widget)
    
    @widgets.length = 0

class Button
  constructor: (text, x, y, cls = null) ->
    @el = document.createElement('button')
    @el.className = cls if cls?
    @setText(text)
    @setStyle(position: 'absolute', left: "#{x}px", top: "#{y}px")

    love.eventify(this)
    @el.addEventListener('click', @_click)

  _click: =>
    @trigger('click')

  setStyle: ->
    if arguments.length is 2
      [key, value] = arguments
      @el.style[key] = value
    else
      for key, value of arguments[0]
        @setStyle(key, value)

  setText: (text) ->
    @el.textContent = text

  getElement: ->
    @el
