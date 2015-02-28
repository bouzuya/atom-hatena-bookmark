HatenaBookmarkListElement = require '../lib/hatena-bookmark-list-element'

describe 'HatenaBookmarkListElement', ->
  describe 'instance', ->
    element = null

    beforeEach ->
      element = new HatenaBookmarkListElement

    it 'should be defined "initialize"', ->
      expect(element.initialize).toBeDefined()
