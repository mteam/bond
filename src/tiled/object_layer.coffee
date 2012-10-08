class ObjectLayer
  type: 'object'

  @create: (json, map) ->
    layer = new ObjectLayer
    layer.name = json.name
    layer.objects = json.objects

    layer

  type: (type) ->
    object for object in @objects when object.type is type

  get: (name) ->
    for object in @objects when object.name is name
      return object

module.exports = ObjectLayer
