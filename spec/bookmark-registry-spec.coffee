BookmarkRegistry = require '../lib/bookmark-registry'

describe 'BookmarkRegistry', ->
  describe 'instance', ->
    registry = null

    beforeEach ->
      registry = new BookmarkRegistry

    it 'should be defined "fetch"', ->
      expect(registry.fetch).toBeDefined()
