HatenaBookmarkList = require '../lib/hatena-bookmark-list'

describe 'HatenaBookmarkList', ->
  describe 'constructor', ->
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
