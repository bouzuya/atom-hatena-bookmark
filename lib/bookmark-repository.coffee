module.exports = class BookmarkRepository
  # public
  constructor: (@downloader) ->
    @bookmarks = []

  # public
  getPage: (offset = 0) ->
    new Promise (resolve, reject) =>
      if @bookmarks.length > offset
        resolve @bookmarks[offset...(offset + 20)]
        return
      @downloader.fetch offset
      .then (bookmarks) =>
        @merge bookmarks
        @bookmarks[offset...(offset + 20)]
      .then resolve, reject

  merge: (bookmarks) ->
    news = bookmarks.filter (i) =>
      @bookmarks.every (j) ->
        i.bookmarkUrl isnt j.bookmarkUrl
    news.forEach (i) =>
      @bookmarks.push i
    news
