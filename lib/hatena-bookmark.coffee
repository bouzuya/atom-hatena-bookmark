{CompositeDisposable} = require 'atom'
BookmarkDownloader = require './bookmark-downloader'
BookmarkRepository = require './bookmark-repository'
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
      'hatena-bookmark:open-url': => @openUrl()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:next-page': => @model?.nextPage()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hatena-bookmark:previous-page': => @model?.previousPage()

    @subscriptions.add atom.views.addViewProvider HatenaBookmarkList, (model) ->
      new HatenaBookmarkListElement().initialize(model)

  # public
  deactivate: ->
    @subscriptions.dispose()

  attach: ->
    downloader = new BookmarkDownloader
    repository = new BookmarkRepository downloader
    @model = new HatenaBookmarkList repository
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

  openUrl: ->
    @model.openUrl()

  toggle: ->
    if @attached()
      @detach()
    else
      @attach()
