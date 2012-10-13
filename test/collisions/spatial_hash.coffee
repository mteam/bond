AABB = require '../../src/collisions/aabb'
SpatialHash = require '../../src/collisions/spatial_hash'

describe 'SpatialHash', ->
  a = { aabb: new AABB(100, 100, 200, 200) }
  b = { aabb: new AABB(150, 150, 250, 250) }
  c = { aabb: new AABB(300, 300, 400, 400) }

  describe '#coords', ->
    it 'should calculate coordinates', ->
      sh = new SpatialHash(50)

      sh.coords(new AABB(0, 0, 100, 100))
        .should.be.eql(x1: 0, y1: 0, x2: 1, y2: 1)

      sh.coords(new AABB(75, 125, 175, 225))
        .should.be.eql(x1: 1, y1: 2, x2: 3, y2: 4)

  describe '#cell', ->
    it 'should create non-existent cells', ->
      sh = new SpatialHash(50)

      sh.cell(5, 5).should.be.empty
      sh.hash.should.have.property('5x5')

    it 'should return existent cells', ->
      sh = new SpatialHash(50)
      obj = { foo: 'bar' }

      sh.cell(5, 5).push(obj)
      sh.cell(5, 5).should.eql([obj])
      sh.hash['5x5'].should.eql([obj])

  describe '#insert', ->
    it 'should insert a correctly with size 50', ->
      sh = new SpatialHash(50)
      sh.insert(a.aabb, a)

      ###
         0 1 2 3 4 
      0 | | | | | |
      1 | | | | | |
      2 | | |x|x| |
      3 | | |x|x| |
      4 | | | | | |
      ###

      sh.hash.should.have.keys('2x2', '2x3', '3x2', '3x3')

    it 'should insert a correctly with size 75', ->
      sh = new SpatialHash(75)
      sh.insert(a.aabb, a)

      ###
         0 1 2 3 4 
      0 | | | | | |
      1 | |.|.| | |
      2 | |.|.| | |
      3 | | | | | |
      4 | | | | | |
      ###

      sh.hash.should.have.keys('1x1', '1x2', '2x1', '2x2')

    it 'should insert a and b correctly', ->
      sh = new SpatialHash(50)
      sh.insert(a.aabb, a)
      sh.insert(b.aabb, b)

      ###
         0 1 2 3 4 5
      0 | | | | | | |
      1 | | | | | | |
      2 | | |x|x| | |
      3 | | |x|X|x| |
      4 | | | |x|x| |
      5 | | | | | | |
      ###

      
      sh.hash.should.have.property('2x2').with.lengthOf(1)
      sh.hash.should.have.property('2x3').with.lengthOf(1)
      sh.hash.should.have.property('3x2').with.lengthOf(1)
      sh.hash.should.have.property('3x3').with.lengthOf(2)
      sh.hash.should.have.property('3x4').with.lengthOf(1)
      sh.hash.should.have.property('4x3').with.lengthOf(1)
      sh.hash.should.have.property('4x4').with.lengthOf(1)

  describe '#collisions', ->
    it 'should not detect any collisions with one object', ->
      sh = new SpatialHash(50)
      sh.insert(a.aabb, a)

      sh.collisions(a.aabb, a).should.be.empty

    it 'should not detect any collisions with distant objects', ->
      sh = new SpatialHash(50)
      sh.insert(a.aabb, a)
      sh.insert(c.aabb, c)

      sh.collisions(a.aabb, a).should.be.empty

    it 'should detect collisions', ->
      sh = new SpatialHash(50)
      sh.insert(a.aabb, a)
      sh.insert(b.aabb, b)

      sh.collisions(a.aabb, a).should.be.eql([b])
