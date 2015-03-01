describe 'HatenaBookmark', ->
  describe 'package', ->
    pkg = null

    beforeEach ->
      pkg = require '../lib/hatena-bookmark'

    it 'should be defined "activate"', ->
      expect(pkg.activate).toBeDefined()

    it 'should be defined "config"', ->
      expect(pkg.config).toBeDefined()

    it 'should be defined "deactivate"', ->
      expect(pkg.deactivate).toBeDefined()
