Bookmark = require '../lib/bookmark'

describe 'Bookmark', ->
  describe 'constructor', ->
    bookmark = null

    beforeEach ->
      bookmark = new Bookmark
        bookmarkedAt: '2015-03-01T00:00:00Z'
        bookmarkUrl: 'http://b.hatena.ne.jp/bouzuya/20150101#bookmark-12345'
        comment: 'no comment'
        commentUrl: 'http://example.com/comment/url'
        title: 'title'
        url: 'http://example.com/url'

    it 'should have "bookmarkedAt"', ->
      expect(bookmark.bookmarkedAt).toBe '2015-03-01T00:00:00Z'

    it 'should have "bookmarkUrl"', ->
      bookmarkUrl = 'http://b.hatena.ne.jp/bouzuya/20150101#bookmark-12345'
      expect(bookmark.bookmarkUrl).toBe bookmarkUrl

    it 'should have "comment"', ->
      expect(bookmark.comment).toBe 'no comment'

    it 'should have "commentUrl"', ->
      expect(bookmark.commentUrl).toBe 'http://example.com/comment/url'

    it 'should have "title"', ->
      expect(bookmark.title).toBe 'title'

    it 'should have "url"', ->
      expect(bookmark.url).toBe 'http://example.com/url'
