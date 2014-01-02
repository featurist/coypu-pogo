fs = require 'fs'
app = require './example_app/app'
chromedriver = require '../src/chromedriver'
browser = require '../src/browser'

describe 'browser'

    brow = nil
    proc = nil

    before
        this.timeout 4000
        proc := chromedriver.start!
        brow := browser.open!
        app.listen! 3003
        brow.status!.build.version.should.exist
        brow.visit! 'http://127.0.0.1:3003/'

    after
        brow.close!
        proc.stop!

    it 'visits urls'
        brow.current url!.should.equal 'http://127.0.0.1:3003/'

    it 'returns the source of the current page'
        brow.source!.should.contain 'Well, Hello'

    it 'returns the title of the current page'
        brow.title!.should.contain 'Home Page'

    it 'executes scripts'
        brow.execute script!('return window.location.href').should.equal 'http://127.0.0.1:3003/'
