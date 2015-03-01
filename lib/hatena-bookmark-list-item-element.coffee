class HatenaBookmarkListItemElement extends HTMLElement
  # public
  constructor: ->

  # public
  getModel: ->
    @model

  # public
  initialize: (@model) ->
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

module.exports = document.registerElement 'hatena-bookmark-list-item',
  prototype: HatenaBookmarkListItemElement.prototype
  extends: 'li'
