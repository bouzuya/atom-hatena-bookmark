request = require 'request'
{parseString} = require 'xml2js'
Bookmark = require './bookmark'

module.exports = class BookmarkDownloader
  # public
  constructor: ->

  # public
  fetch: ->
    new Promise (resolve, reject) ->
      oauth =
        consumer_key: atom.config.get 'hatena-bookmark.consumerKey'
        consumer_secret: atom.config.get 'hatena-bookmark.consumerSecret'
        token: atom.config.get 'hatena-bookmark.token'
        token_secret: atom.config.get 'hatena-bookmark.tokenSecret'

      request
        method: 'GET'
        url: 'http://b.hatena.ne.jp/atom/feed'
        oauth: oauth
        headers:
          'User-Agent': 'atom-hatena-bookmark'
      , (e, r) ->
        return reject(e) if e?
        parseString r.body, (e, r) ->
          return callback e, null if e?
          bookmarks = r.feed.entry.map (i) ->
            new Bookmark
              bookmarkedAt: i.issued[0]
              bookmarkUrl: i.link[1].$.href
              comment: i.summary[0]
              # commentUrl
              title: i.title[0]
              url: i.link[0].$.href
          resolve bookmarks
