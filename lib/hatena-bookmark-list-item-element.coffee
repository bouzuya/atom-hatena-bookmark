{CompositeDisposable} = require 'atom'

class HatenaBookmarkListItemElement extends HTMLElement
  # public
  constructor: ->

  # public
  getModel: ->
    @model

  # public
  initialize: (@model) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add @model.onDidChange @onDidChange.bind @
    @subscriptions.add @model.onDidDestroy => @subscriptions.dispose()
    @classList.add 'bookmark'
    @appendChild @buildSpan(@model.bookmarkedAt, 'bookmarked-at')
    @appendChild @buildSpan(@model.title, 'title')
    @dataset.bookmarkUrl = @model.bookmarkUrl
    @dataset.title = @model.title
    @

  buildSpan: (text, classes) ->
    span = document.createElement 'span'
    span.classList.add.apply span.classList, classes.split(' ')
    span.appendChild document.createTextNode text
    span

  onDidChange: (model) ->
    if model.selected
      @classList.add 'selected'
    else
      @classList.remove 'selected'

module.exports = document.registerElement 'hatena-bookmark-list-item',
  prototype: HatenaBookmarkListItemElement.prototype
  extends: 'li'
