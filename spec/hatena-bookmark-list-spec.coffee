HatenaBookmarkList = require '../lib/hatena-bookmark-list'

describe 'HatenaBookmarkList', ->
  describe 'instance', ->
    list = null

    beforeEach ->
      registry =
        fetch: ->
          Promise.resolve()
      list = new HatenaBookmarkList registry

    it 'should be defined "destroy"', ->
      expect(list.destroy).toBeDefined()

    it 'should be defined "fetch"', ->
      expect(list.fetch).toBeDefined()

    it 'should be defined "onAddBookmark"', ->
      expect(list.onAddBookmark).toBeDefined()

    it 'should be defined "onDidDestroy"', ->
      expect(list.onDidDestroy).toBeDefined()

    it 'should be defined "onSetBookmarks"', ->
      expect(list.onSetBookmarks).toBeDefined()

  describe 'destroy()', ->
    list = null

    beforeEach ->
      registry =
        fetch: ->
          Promise.resolve()
      list = new HatenaBookmarkList registry

    it 'should call onDidDestroy subscription', ->
      subscription = jasmine.createSpy 'destroyed'
      list.onDidDestroy subscription
      list.destroy()
      runs ->
        expect(subscription).toHaveBeenCalledWith list

