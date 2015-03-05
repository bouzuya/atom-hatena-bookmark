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
    throw new Error('invalid bookmark url') unless @isBookmarkUrl @bookmarkUrl
    throw new Error('invalid url') unless @isUrl @url

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

  # http://b.hatena.ne.jp/{userId}/{date}#bookmark-{entryId}
  isBookmarkUrl: (url) ->
    p = new RegExp '^https?://b.hatena.ne.jp/[^/]+/\\d{8}#bookmark-\\d+$'
    url.match p

  # http://b.hatena.ne.jp/entry/{entryId}/comment/{userId}
  isCommentUrl: (url) ->
    p = new RegExp '^https?://b.hatena.ne.jp/entry/\\d+/comment/[^/]+$'
    url.match p

  # http://b.hatena.ne.jp/entry/example.com/index.html
  isEntryUrl: (url) ->
    p = new RegExp '^https?://b.hatena.ne.jp/entry/.+$'
    url.match p

  # http://example.com
  isUrl: (url) ->
    p = new RegExp '^https?://.+$'
    url.match p
