class Queue
  constructor: (@worker, @done) ->
    @tasks = []

  push: (task) ->
    @tasks.push(task)

  start: ->
    @next()

  next: =>
    task = @tasks.shift()

    if task?
      @worker(task, @next)
    else
      @done()

module.exports = Queue
