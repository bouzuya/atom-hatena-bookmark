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
    @selected = false

  # public
  destroy: ->
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  # public
  onDidChange: (callback) ->
    @emitter.on 'did-change', callback

  # public
  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  # public
  select: ->
    @selected = !@selected
    @emitter.emit 'did-change', @
