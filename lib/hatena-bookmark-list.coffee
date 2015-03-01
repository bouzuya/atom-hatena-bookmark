{Emitter} = require 'atom'

module.exports = class HatenaBookmarkList
  # public
  constructor: (@registry) ->
    @emitter = new Emitter

  # public
  destroy: ->
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  # public
  fetch: ->
    @registry.fetch()
    .then @setBookmarks.bind @

  # public
  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  # public
  onSetBookmarks: (callback) ->
    @emitter.on 'did-set-bookmarks', callback

  setBookmarks: (bookmarks) ->
    @emitter.emit 'did-set-bookmarks', bookmarks
