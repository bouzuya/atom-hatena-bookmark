Bookmark = require './bookmark'
bookmark = require 'hatena-bookmark-api'

module.exports = class BookmarkDownloader
  # public
  constructor: ->

  # public
  fetch: (offset = 0)->
    client = bookmark
      type: 'oauth'
      consumerKey: atom.config.get 'hatena-bookmark.consumerKey'
      consumerSecret: atom.config.get 'hatena-bookmark.consumerSecret'
      token: atom.config.get 'hatena-bookmark.token'
      tokenSecret: atom.config.get 'hatena-bookmark.tokenSecret'
    client.index({ of: offset })
    .then (res) ->
      res.feed.entry.map (i) ->
        url = i.link.filter((j) -> j.$.rel is 'related')[0]?.$.href
        bookmarkUrl = i.link.filter((j) -> j.$.rel is 'alternate')[0]?.$.href
        editUrl = i.link.filter((j) -> j.$.rel is 'service.edit')[0]?.$.href
        new Bookmark
          bookmarkedAt: i.issued._
          bookmarkUrl: bookmarkUrl
          comment: i.summary._
          # commentUrl
          title: i.title._
          url: url
