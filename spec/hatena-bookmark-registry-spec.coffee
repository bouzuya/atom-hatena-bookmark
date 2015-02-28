HatenaBookmarkRegistry = require '../lib/hatena-bookmark-registry'

describe 'HatenaBookmarkRegistry', ->
  describe 'instance', ->
    registry = null

    beforeEach ->
      registry = new HatenaBookmarkRegistry

    it 'should be defined "fetch"', ->
      expect(registry.fetch).toBeDefined()
