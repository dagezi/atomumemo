{CompositeDisposable} = require 'atom'
path = require 'path'

Universe = require './universe'

module.exports = Atomumemo =
  subscriptions: null
  universes: [
    new Universe name: "default", dir: "c:\\tmp\\mumemo"
  ]

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atomumemo:create': => @createFile()

  deactivate: ->
    @subscriptions.dispose()

  createFile: ->
    memo = @universes[0]?.createMemo()
    atom.workspace.open(memo.getUrl())
