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

    it 'should be defined "onDidDestroy"', ->
      expect(list.onDidDestroy).toBeDefined()

    it 'should be defined "onSetBookmarks"', ->
      expect(list.onSetBookmarks).toBeDefined()

  describe '::destroy and ::onDidDestroy', ->
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

  describe '::fetch and ::onSetBookmarks', ->
    [list, bookmarks] = []

    describe 'when resolved', ->
      beforeEach ->
        bookmarks = [1, 2, 3]
        registry =
          fetch: ->
            Promise.resolve(bookmarks)
        list = new HatenaBookmarkList registry

      it 'should call onSetBookmarks subscription', ->
        subscription = jasmine.createSpy 'set-bookmarks'
        waitsForPromise ->
          list.onSetBookmarks subscription
          list.fetch()
        runs ->
          expect(subscription).toHaveBeenCalledWith bookmarks

    describe 'when rejected', ->
      beforeEach ->
        registry =
          fetch: ->
            Promise.reject()
        list = new HatenaBookmarkList registry

      it 'should not call onSetBookmarks subscription', ->
        subscription = jasmine.createSpy 'set-bookmarks'
        reject = jasmine.createSpy 'reject'
        waitsForPromise ->
          list.onSetBookmarks subscription
          list.fetch()
          .catch reject
        runs ->
          expect(subscription).not.toHaveBeenCalled()
          expect(reject).toHaveBeenCalled()
