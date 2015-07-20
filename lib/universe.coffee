path = require 'path'

module.exports =
class Universe
  constructor: ({@name, @dir}) ->

  getDir: ()->
    @dir

  getUrl: ()->
    @filePathToUrl(@dir)

  filePathToUrl: (filePath)->
    "file:///" + filePath.replace(path.sep, '/').replace(' ', '%20')
    # TODO: support more escapes
