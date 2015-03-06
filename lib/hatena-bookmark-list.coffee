open = require 'open'
{Emitter} = require 'atom'
HatenaBookmarkListItem = require './hatena-bookmark-list-item'

module.exports = class HatenaBookmarkList
  # public
  constructor: (@repository) ->
    @bookmarks = []
    @offset = 0
    @emitter = new Emitter

  # public
  destroy: ->
    i.destroy() for i in @bookmarks
    @bookmarks = []
    @emitter.emit 'did-destroy', @
    @emitter.dispose()

  # public
  fetch: ->
    @repository.getPage @offset
    .then (bookmarks) =>
      i.destroy() for i in @bookmarks
      @bookmarks = (new HatenaBookmarkListItem(i) for i in bookmarks)
      @emitter.emit 'did-set-bookmarks', @bookmarks

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

  # public
  openUrl: ->
    open i.url for i in @bookmarks when i.selected

  # public
  nextPage: ->
    @offset += 20
    @fetch()

  # public
  previousPage: ->
    @offset -= 20
    @offset = 0 if @offset < 0
    @fetch()

  format: (bookmark) ->
    "[#{bookmark.title}](#{bookmark.url})"
