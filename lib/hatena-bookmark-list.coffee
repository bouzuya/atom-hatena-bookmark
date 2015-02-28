{Emitter} = require 'atom'
HatenaBookmarkRegistry = require './hatena-bookmark-registry'

module.exports = class HatenaBookmarkList
  # public
  constructor: ->
    @emitter = new Emitter

    @registry = new HatenaBookmarkRegistry
    @registry.fetch()
    .then @setBookmarks.bind @

  # public
  destroy: ->
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  addBookmark: (bookmark) ->
    @emitter.emit 'did-add-bookmark', bookmark

  onAddBookmark: (callback) ->
    @emitter.on 'did-add-bookmark', callback

  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  onSetBookmarks: (callback) ->
    @emitter.on 'did-set-bookmarks', callback

  setBookmarks: (bookmarks) ->
    @emitter.emit 'did-set-bookmarks', bookmarks
