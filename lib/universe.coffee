path = require 'path'
fs = require 'fs-plus'
{sprintf} = require 'sprintf'

Memo = require './memo'
Util = require './util'

module.exports =
class Universe
  constructor: ({@name, @dir}) ->
    @memos = {}

  getDir: ()->
    @dir

  getUrl: ()->
    @filePathToUrl(@dir)

  createMemo: (date)->
    date ||= new Date()
    newPath = path.join(
      sprintf('%4d', date.getYear() + 1900),
      sprintf('%02d', date.getMonth() + 1),
      sprintf('%02d-%02d%02d%02d.md'
        date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds()))
    memo = new Memo universe: this, path: newPath
    @memos[newPath] = memo
    memo

  loadMemo: (relPath)->
    if !memos[relPath]
      memo = new Memo universe: this, path: relPath
      memo.bindToFile()
    memos[relPath] = memo

  loadAllMemos: (onDone)->
    rootDir = @getDir
    fs.traverseTree(rootDir
      , (absPath)->
        if Util.isTargetFile(absPath)
          relPath = path.relative(rootDir, absPath)
          loadMemo: (relPath)
      , (absPath)->
        !path.basename(absPath).match(/^\./)
      ,onDone)
