{CompositeDisposable} = require 'atom'
BookmarkDownloader = require './bookmark-downloader'
HatenaBookmarkList = require './hatena-bookmark-list'
HatenaBookmarkListElement = require './hatena-bookmark-list-element'

module.exports =
  # public
  config:
    consumerKey:
      type: 'string'
      default: ''
    consumerSecret:
      type: 'string'
      default: ''
    token:
      type: 'string'
      default: ''
    tokenSecret:
      type: 'string'
      default: ''

  panel: null
  subscriptions: null

  # public
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:insert': => @insert()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:open-comment-url': => @openCommentUrl()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:toggle': => @toggle()
    @subscriptions.add atom.views.addViewProvider HatenaBookmarkList, (model) ->
      new HatenaBookmarkListElement().initialize(model)

  # public
  deactivate: ->
    @subscriptions.dispose()

  attach: ->
    @model = new HatenaBookmarkList new BookmarkDownloader
    item = atom.views.getView @model
    @panel = atom.workspace.addLeftPanel item: item
    @panel.onDidDestroy => @model.destroy()
    @model.fetch()

  attached: ->
    @panel?

  detach: ->
    @panel.destroy()
    @panel = null

  insert: ->
    @model.insert()

  openCommentUrl: ->
    @model.openCommentUrl()

  toggle: ->
    if @attached()
      @detach()
    else
      @attach()
