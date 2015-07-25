{CompositeDisposable} = require 'atom'
path = require 'path'

Universe = require './universe'

module.exports = Atomumemo =
  subscriptions: null
  universes: []

  config:
    universe0Name:
      type: 'string'
      default: 'default'
    universe0Dir:
      type: 'string'
      default: "c:\\tmp\\mumemo"
    universe1Name:
      type: 'string'
      default: null
    universe1Dir:
      type: 'string'
      default: null


  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atomumemo:create': => @createFile()
    @universes.push(
      new Universe {
        name: atom.config.get('atomumemo.universe0Name')
        dir: atom.config.get('atomumemo.universe0Dir')
      })


  deactivate: ->
    @subscriptions.dispose()

  createFile: ->
    memo = @universes[0]?.createMemo()
    atom.workspace.open(memo.getAbsolutePath())
