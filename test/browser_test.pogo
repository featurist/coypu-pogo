fs = require 'fs'
chromedriver = require '../src/chromedriver'
browser = require '../src/browser'

describe 'browser'

    brow = nil
    proc = nil

    before
        this.timeout 4000
        proc := chromedriver.start!
        brow := browser.open!
        brow.status!.build.version.should.exist
        brow.visit! 'http://www.w3.org/'

    after
        brow.close!
        proc.stop!

    it 'visits urls'
        brow.current url!.should.equal 'http://www.w3.org/'

    it 'returns the source of the current page'
        brow.source!.should.contain 'World Wide Web Consortium'

    it 'returns the title of the current page'
        brow.title!.should.contain 'W3C'

    it 'executes scripts'
        brow.execute script!('return window.location.href').should.equal 'http://www.w3.org/'
