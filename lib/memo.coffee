path = require 'path'
fs = require 'fs-plus'

Util = require './util'

module.exports =
class Memo
  constructor: ({@universe, @path}) ->
    @mtime = 0
    @snippet = 0

  getAbsolutePath: ()->
    path.join(@universe.getDir(), @path)

  getUrl: ()->
    Util.filePathToUrl(@getAbsolutePath())

  # load information from real file
  bindToFile: ()->
    absPath = @getAbsolutePath()
    stat = fs.statSync(absPath)
    if (stat)
      @mtime = stat.mtime
      # TODO: load snippet
