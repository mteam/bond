Component = require './component'

capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.substr(1)

uncapitalize = (str) ->
  str.charAt(0).toLowerCase() + str.substr(1)

class Container extends Component
  PREFIX = 'createComponent'

  _createComponents: ->
    @_cs = {}

    for key, value of this when key.substr(0, PREFIX.length) is PREFIX
      name = uncapitalize(key.substr(PREFIX.length))

      if not @_cs[name]?
        @_createComponent(name)

  getComponent: (name) ->
    if @_cs[name]?
      return @_cs[name]
    else
      return @_createComponent(name)

  _createComponent: (name) ->
    factory = PREFIX + capitalize(name)

    if @[factory]?
      component = @[factory]()
      component.setParent(this)

      if component instanceof Container
        component._createComponents()

      @_cs[name] = component
      @[name] ?= component

      return component
    else
      throw new Error("Couldn't create component #{name} in #{@constructor.name}")

module.exports = Container
