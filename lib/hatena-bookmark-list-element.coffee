{CompositeDisposable, Disposable} = require 'atom'
HatenaBookmarkListItemElement = require './hatena-bookmark-list-item-element'

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

  destroyed: ->
    @subscriptions.dispose() if @subscriptions?
    @parentNode?.removeChild @

  findBookmarkElement: (e) ->
    while true
      return null unless e?
      return null if e.classList.contains 'hatena-bookmark-list'
      return e if e.classList.contains 'bookmark'
      e = e.parentNode

  onClick: (e) ->
    el = @findBookmarkElement e.target
    return unless el?
    bookmark = el.getModel()
    bookmark.select()

  setBookmarks: (bookmarks) ->
    @removeChild @firstChild while @firstChild
    for bookmark in bookmarks
      li = new HatenaBookmarkListItemElement().initialize bookmark
      @appendChild li
    @

module.exports = document.registerElement 'hatena-bookmark-list',
  prototype: HatenaBookmarkListElement.prototype
  extends: 'ul'
