{Emitter} = require 'atom'
BookmarkRegistry = require './bookmark-registry'

module.exports = class HatenaBookmarkList
  # public
  constructor: ->
    @emitter = new Emitter
    @registry = new BookmarkRegistry

  # public
  destroy: ->
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  # public
  fetch: ->
    @registry.fetch()
    .then @setBookmarks.bind @

  # public
  onAddBookmark: (callback) ->
    @emitter.on 'did-add-bookmark', callback

  # public
  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  # public
  onSetBookmarks: (callback) ->
    @emitter.on 'did-set-bookmarks', callback

  addBookmark: (bookmark) ->
    @emitter.emit 'did-add-bookmark', bookmark

  setBookmarks: (bookmarks) ->
    @emitter.emit 'did-set-bookmarks', bookmarks
