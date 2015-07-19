AtomumemoView = require './atomumemo-view'
{CompositeDisposable} = require 'atom'

module.exports = Atomumemo =
  atomumemoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    console.log 'atomumemo activate'
    @atomumemoView = new AtomumemoView(state.atomumemoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomumemoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atomumemo:create': => @createFile()
    console.log 'atomumemo activate done'

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomumemoView.destroy()

  serialize: ->
    atomumemoViewState: @atomumemoView.serialize()

  createFile: ->
    console.log 'Atomumemo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
