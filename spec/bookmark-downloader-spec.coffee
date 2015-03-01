BookmarkDownloader = require '../lib/bookmark-downloader'

describe 'BookmarkDownloader', ->
  describe 'instance', ->
    instance = null

    beforeEach ->
      instance = new BookmarkDownloader

    it 'should be defined "fetch"', ->
      expect(instance.fetch).toBeDefined()
