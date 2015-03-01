HatenaBookmarkListItemElement =
  require '../lib/hatena-bookmark-list-item-element'

describe 'HatenaBookmarkListItemElement', ->
  describe 'instance', ->
    element = null

    beforeEach ->
      element = new HatenaBookmarkListItemElement

    it 'should be defined "initialize"', ->
      expect(element.initialize).toBeDefined()
