open = require 'open'
{CompositeDisposable, Disposable} = require 'atom'

class HatenaBookmarkListElement extends HTMLElement
  # public
  constructor: ->

  # public
  initialize: (@model) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add @model.onSetBookmarks @setBookmarks.bind @
    @subscriptions.add @model.onDidDestroy @destroyed.bind @
    @addEventListener 'click', @onClick.bind(@), true
    @subscriptions.add new Disposable =>
      @removeEventListener 'click', @onClick.bind(@)
    @

  addBookmark: (bookmark) ->
    @appendChild @buildListItem bookmark

  bookmarkClicked: (bookmarkElement) ->
    title = bookmarkElement.dataset.title
    url = bookmarkElement.dataset.bookmarkUrl
    text = "[#{title}](#{url})"
    atom.workspace.getActiveTextEditor().insertText text

  buildListItem: (bookmark) ->
    li = document.createElement 'li'
    li.classList.add 'bookmark'
    li.appendChild @buildSpan(bookmark.bookmarkedAt, 'bookmarked-at')
    li.appendChild @buildSpan(bookmark.title, 'title')
    li.dataset.bookmarkUrl = bookmark.bookmarkUrl
    li.dataset.title = bookmark.title
    li

  buildSpan: (text, classes) ->
    span = document.createElement 'span'
    span.classList.add.apply span.classList, classes.split(' ')
    span.appendChild document.createTextNode text
    span

  destroyed: ->
    @subscriptions.dispose() if @subscriptions?
    @parentNode?.removeChild @

  onClick: (e) ->
    el = e.target
    el = el.parentNode while el? and (
      el.classList.contains('hatena-bookmark-list') or \
      !el.classList.contains('bookmark')
    )
    return unless el?.classList.contains 'bookmark'
    bookmarkElement = el
    @bookmarkClicked bookmarkElement

  setBookmarks: (bookmarks) ->
    @removeChild @firstChild while @firstChild
    bookmarks.forEach @addBookmark.bind @
    @

module.exports = document.registerElement 'hatena-bookmark-list',
  prototype: HatenaBookmarkListElement.prototype
  extends: 'ul'
