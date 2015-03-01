{Emitter} = require 'atom'

module.exports = class Bookmark
  # public
  constructor: ({
    @bookmarkedAt
    @bookmarkUrl
    @comment
    @commentUrl
    @title
    @url
  }) ->
    @emitter = new Emitter

  # public
  destroy: ->
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  # public
  insert: ->
    text = "[#{@title}](#{@url})"
    atom.workspace.getActiveTextEditor().insertText text

  # public
  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback
