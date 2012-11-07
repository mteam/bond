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

  describe '#resolve', ->
    a =
      rect: new AABB(0, 0, 400, 400)
      wide: new AABB(0, 0, 1000, 50)

    test = (x1, y1, x2, y2, vx, vy, key = 'rect') ->
      it "should work at [#{x1}; #{y1}] with #{key}", ->
        b = new AABB(x1, y1, x2, y2)

        v = a[key].resolve(b)

        v.should.have.property('x', vx)
        v.should.have.property('y', vy)

    context 'when on the edge', ->
      test(350, 50, 450, 150, 50, 0)
      test(350, 250, 450, 350, 50, 0)
      test(50, 350, 150, 450, 0, 50)
      test(250, 350, 350, 450, 0, 50)

      test(-50, 50, 50, 150, -50, 0)
      test(-50, 250, 50, 350, -50, 0)
      test(50, -50, 150, 50, 0, -50)
      test(250, -50, 350, 50, 0, -50)

      test(800, -40, 850, 10, 0, -10, 'wide')

    context 'when inside', ->
      test(50, 50, 100, 150, -100, 0)
      test(250, 50, 350, 100, 0, -100)
      test(300, 250, 350, 350, 100, 0)
      test(50, 300, 150, 350, 0, 100)

  describe '#distanceTo', ->
    it 'should work correctly', ->
      a = new AABB(10, 10, 20, 20)
      b = new AABB(30, 30, 40, 40)
      c = new AABB(200, 0, 300, 700)

      dist = a.distanceTo(b)

      dist.should.have.property('x', 20)
      dist.should.have.property('y', 20)

      dist = a.distanceTo(c)

      dist.x.should.equal(235)
      dist.y.should.equal(335)