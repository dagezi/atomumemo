{CompositeDisposable} = require 'atom'
{sprintf} = require 'sprintf'

module.exports = Atomumemo =
  subscriptions: null
  universes:
    default:
      dir: "file:///tmp/mumemo"

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atomumemo:create': => @createFile()

  deactivate: ->
    @subscriptions.dispose()

  createFile: ->
    console.log "createFile"
    date = new Date()
    uri = sprintf('%s/%4d/%02d/%02d-%02d%02d%02d.md',
      @universes.default.dir, date.getYear() + 1900, date.getMonth(), date.getDate(),
      date.getHours(), date.getMinutes(), date.getSeconds())
    atom.workspace.open(uri)
