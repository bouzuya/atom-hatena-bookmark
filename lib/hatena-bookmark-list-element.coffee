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

  onClick: (e) ->
    el = e.target
    el = el.parentNode while el? and (
      el.classList.contains('hatena-bookmark-list') or \
      !el.classList.contains('bookmark')
    )
    return unless el?.classList.contains 'bookmark'
    bookmark = el.getModel()
    bookmark.insert()

  setBookmarks: (bookmarks) ->
    @removeChild @firstChild while @firstChild
    for bookmark in bookmarks
      li = new HatenaBookmarkListItemElement().initialize bookmark
      @appendChild li
    @

module.exports = document.registerElement 'hatena-bookmark-list',
  prototype: HatenaBookmarkListElement.prototype
  extends: 'ul'
