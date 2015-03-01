module.exports = class Bookmark
  # public
  constructor: ({
    @bookmarkedAt
    @bookmarkUrl
    @comment
    @commentUrl
    @title
    @url
  }) ->

  insert: ->
    text = "[#{@title}](#{@url})"
    atom.workspace.getActiveTextEditor().insertText text
