path = require 'path'

module.exports = Util =
  filePathToUrl: (filePath)->
    "file:///" + filePath.replace(path.sep, '/').replace(' ', '%20')
    # TODO: support more escapes

  isTargetFile: (filePath)->
    !!filePath.match(/\.md$/)
