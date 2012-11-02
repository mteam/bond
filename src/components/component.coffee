class Component
  setParent: (@parent) ->
    @attached?()

module.exports = Component
