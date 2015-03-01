Bookmark = require '../lib/bookmark'

describe 'Bookmark', ->
  describe 'constructor', ->
    bookmark = null

    beforeEach ->
      bookmark = new Bookmark
        bookmarkedAt: '2015-03-01T00:00:00Z'
        bookmarkUrl: 'http://example.com/bookmark/url'
        comment: 'no comment'
        commentUrl: 'http://example.com/comment/url'
        title: 'title'
        url: 'http://example.com/url'

    it 'should have "bookmarkedAt"', ->
      expect(bookmark.bookmarkedAt).toBe '2015-03-01T00:00:00Z'

    it 'should have "bookmarkUrl"', ->
      expect(bookmark.bookmarkUrl).toBe 'http://example.com/bookmark/url'

    it 'should have "comment"', ->
      expect(bookmark.comment).toBe 'no comment'

    it 'should have "commentUrl"', ->
      expect(bookmark.commentUrl).toBe 'http://example.com/comment/url'

    it 'should have "title"', ->
      expect(bookmark.title).toBe 'title'

    it 'should have "url"', ->
      expect(bookmark.url).toBe 'http://example.com/url'

    it 'should be defined "destroy"', ->
      expect(bookmark.destroy).toBeDefined()

    it 'should be defined "insert"', ->
      expect(bookmark.insert).toBeDefined()

    it 'should be defined "onDidDestroy"', ->
      expect(bookmark.onDidDestroy).toBeDefined()
