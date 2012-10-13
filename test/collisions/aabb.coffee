AABB = require '../../src/collisions/aabb'

describe 'AABB', ->
  describe '#overlaps', ->
    it 'should return false when not overlapping', ->
      a = new AABB(100, 100, 200, 200)
      b = new AABB(300, 300, 400, 400)

      AABB.overlaps(a, b).should.be.false
      AABB.overlaps(b, a).should.be.false

    it 'should return true when overlapping', ->
      a = new AABB(100, 100, 200, 200)
      b = new AABB(150, 150, 250, 250)
      
      AABB.overlaps(a, b).should.be.true
      AABB.overlaps(b, a).should.be.true
