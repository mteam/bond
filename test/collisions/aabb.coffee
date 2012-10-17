should = require 'should'
AABB = require '../../src/collisions/aabb'

describe 'AABB', ->
  describe '.collides', ->
    it 'should return false when not colliding', ->
      a = new AABB(100, 100, 200, 200)
      b = new AABB(300, 300, 400, 400)

      AABB.collides(a, b).should.be.false
      AABB.collides(b, a).should.be.false

    it 'should return true when colliding', ->
      a = new AABB(100, 100, 200, 200)
      b = new AABB(150, 150, 250, 250)
      
      AABB.collides(a, b).should.be.true
      AABB.collides(b, a).should.be.true

    it 'should return true when colliding, but with no corners', ->
      a = new AABB(100, 50, 150, 200)
      b = new AABB(50, 100, 200, 150)

      AABB.collides(a, b).should.be.true
      AABB.collides(a, b).should.be.true

  describe '.overlap', ->
    it 'should return null when not colliding', ->
      a = new AABB(100, 100, 200, 200)
      b = new AABB(300, 300, 400, 400)

      should.not.exist(AABB.overlap(a, b))

    it 'should return overlap when colliding with corners', ->
      a = new AABB(50, 0, 200, 100)
      b = new AABB(0, 50, 100, 200)

      overlap = AABB.overlap(a, b)

      overlap.min.should.eql(x: 50, y: 50)
      overlap.max.should.eql(x: 100, y: 100)

      AABB.overlap(b, a).should.eql(overlap)

    it 'should return overlap when not colliding with corners', ->
      a = new AABB(100, 0, 200, 300)
      b = new AABB(0, 100, 300, 200)

      overlap = AABB.overlap(a, b)

      overlap.min.should.eql(x: 100, y: 100)
      overlap.max.should.eql(x: 200, y: 200)

      AABB.overlap(b, a).should.eql(overlap)

  describe '#move', ->
    it 'should move AABB', ->
      a = new AABB(100, 100, 200, 200)

      a.move(50, -50)

      a.min.should.eql(x: 150, y: 50)
      a.max.should.eql(x: 250, y: 150)
