open = require 'open'
{Emitter} = require 'atom'

module.exports = class HatenaBookmarkList
  # public
  constructor: (@downloader) ->
    @bookmarks = []
    @emitter = new Emitter

  # public
  destroy: ->
    i.destroy() for i in @bookmarks
    @bookmarks = []
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  # public
  fetch: ->
    @downloader.fetch()
    .then (bookmarks) =>
      i.destroy() for i in @bookmarks
      @bookmarks = bookmarks
      @emitter.emit 'did-set-bookmarks', bookmarks

  # public
  insert: ->
    text = (@format i for i in @bookmarks when i.selected).join '\n'
    atom.workspace.getActiveTextEditor().insertText text

  # public
  onDidDestroy: (callback) ->
    @emitter.on 'did-destroy', callback

  # public
  onSetBookmarks: (callback) ->
    @emitter.on 'did-set-bookmarks', callback

  # public
  openCommentUrl: ->
    open i.bookmarkUrl for i in @bookmarks when i.selected

  format: (bookmark) ->
    "[#{bookmark.title}](#{bookmark.url})"
