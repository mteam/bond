vectors = require '../src/vectors'

describe 'Vector', ->
  create = (x, y) ->
    new vectors.Vector(x, y)

  describe '#clone', ->
    it 'should create equal vector', ->
      v = create(3, 4)

      v.clone().should.eql(v)

  describe '#update', ->
    it 'should change vector', ->
      v = create(3, 4)

      v.update(5, 6)

      v.should.have.property('x', 5)
      v.should.have.property('y', 6)

  describe '#add', ->
    it 'should add vector to vector', ->
      v1 = create(3, 4)
      v2 = create(4, 5)

      v1.vadd(v2)

      v1.should.have.property('x', 7)
      v1.should.have.property('y', 9)

  describe '#subtract', ->
    it 'should subtract vector from vector', ->
      v1 = create(3, 4)
      v2 = create(5, 5)

      v2.vsubtract(v1)

      v2.should.have.property('x', 2)
      v2.should.have.property('y', 1)

  describe '#multiply', ->
    it 'should multiply vector', ->
      v = create(3, 4)

      v.multiply(1.5)

      v.should.have.property('x', 4.5)
      v.should.have.property('y', 6)

  describe '#divide', ->
    it 'should divide vector', ->
      v = create(3, 6)

      v.divide(1.5)

      v.should.have.property('x', 2)
      v.should.have.property('y', 4)
