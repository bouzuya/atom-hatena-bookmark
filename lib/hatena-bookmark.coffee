{CompositeDisposable} = require 'atom'
BookmarkRegistry = require './bookmark-registry'
HatenaBookmarkList = require './hatena-bookmark-list'
HatenaBookmarkListElement = require './hatena-bookmark-list-element'

module.exports =
  config:
    consumerKey:
      type: 'string'
    consumerSecret:
      type: 'string'
    token:
      type: 'string'
    tokenSecret:
      type: 'string'
  panel: null
  subscriptions: null

  # public
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:toggle': => @toggle()
    @subscriptions.add atom.views.addViewProvider HatenaBookmarkList, (model) ->
      new HatenaBookmarkListElement().initialize(model)

  # public
  deactivate: ->
    @subscriptions.dispose()

  attach: ->
    model = new HatenaBookmarkList new BookmarkRegistry
    item = atom.views.getView model
    @panel = atom.workspace.addLeftPanel item: item
    @panel.onDidDestroy -> model.destroy()
    model.fetch()

  attached: ->
    @panel?

  detach: ->
    @panel.destroy()
    @panel = null

  toggle: ->
    if @attached()
      @detach()
    else
      @attach()
