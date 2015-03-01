HatenaBookmarkListElement = require '../lib/hatena-bookmark-list-element'

describe 'HatenaBookmarkListElement', ->
  describe 'instance', ->
    element = null

    beforeEach ->
      element = new HatenaBookmarkListElement

    it 'should be defined "initialize"', ->
      expect(element.initialize).toBeDefined()

  describe '::initialize', ->
    element = null

    beforeEach ->
      element = new HatenaBookmarkListElement()

    it 'should have been called HatenaBookmarkList::on*', ->
      # HatenaBookmarkList
      model =
        onSetBookmarks: jasmine.createSpy('onSetBookmarks')
        onDidDestroy: jasmine.createSpy('onDidDestroy')
      element.initialize model
      expect(model.onSetBookmarks).toHaveBeenCalled()
      expect(model.onDidDestroy).toHaveBeenCalled()
