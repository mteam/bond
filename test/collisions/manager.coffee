Manager = require '../../src/collisions/manager'
Collider = require '../../src/collisions/collider'

m = new Manager(30)

player = new Collider
player.setPos(100, 100)
player.setDim(30, 90)
player.collision = (other) ->
  resolve = other.aabb.resolve(player.aabb)
  player.aabb.move(resolve.x, resolve.y)
  player.stop()

  # console.log(player.aabb.min)

platform = new Collider
platform.setPos(0, 200)
platform.setDim(500, 30)
# platform.freeze()
platform.collision = ->
  console.log('platform collision')

m.add(player)
m.add(platform)

player.update(0, 200)
m.update()
