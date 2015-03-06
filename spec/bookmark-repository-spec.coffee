BookmarkDownloader = require '../lib/bookmark-downloader'
BookmarkRepository = require '../lib/bookmark-repository'

describe 'BookmarkRepository', ->
  describe 'constructor', ->
    repository = null

    beforeEach ->
      downloader = new BookmarkDownloader
      repository = new BookmarkRepository downloader

    it 'should have "getPage"', ->
      expect(repository.getPage).toBeDefined()
