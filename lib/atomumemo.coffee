{CompositeDisposable} = require 'atom'
path = require 'path'
{sprintf} = require 'sprintf'

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
    date = new Date()
    uri = path.join(
      @universes[0]?.getDir(),
      sprintf('%4d', date.getYear() + 1900),
      sprintf('%02d', date.getMonth()),
      sprintf('%02d-%02d%02d%02d.md'
        date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds()))
    atom.workspace.open(uri)
