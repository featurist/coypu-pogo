fs = require 'fs'
app = require './example_app/app'
chromedriver = require '../src/chromedriver'
browser = require '../src/browser'
errors = require '../src/errors'

describe 'browser'

    brow = nil
    proc = nil

    before
        this.timeout 4000
        proc := chromedriver.start!
        brow := browser.open!
        app.listen! 3004
        brow.status!.build.version.should.exist

    after
        brow.close!
        proc.stop!

    before each
        brow.visit! 'http://127.0.0.1:3004/'

    it 'visits urls'
        brow.current url!.should.equal 'http://127.0.0.1:3004/'

    it 'returns the source of the current page'
        brow.source!.should.contain 'Well, Hello'

    it 'returns the title of the current page'
        brow.title!.should.contain 'Home Page'

    it 'executes scripts'
        brow.execute script!('return window.location.href').should.equal 'http://127.0.0.1:3004/'

    it 'clicks elements found by css'
        brow.find css 'a'.click!
        brow.current url!.should.equal 'http://127.0.0.1:3004/foo'

    it 'clicks elements found by xpath'
        brow.find xpath './/a[@href]'.click!
        brow.current url!.should.equal 'http://127.0.0.1:3004/foo'

    it 'fails to click non-existent elements by css'
        expect error! (errors.Element Not Found 'a.z' 'css selector')
            brow.find css 'a.z'.click!

    it 'fails to click non-existent elements by xpath'
        expect error! (errors.Element Not Found './/a[@z]' 'xpath')
            brow.find xpath './/a[@z]'.click!


expect error! (expected error, fn) =
    threw = false
    try
        fn!
    catch (e)
        e.to string().should.equal (expected error.to string())
        threw := true

    if (!threw)
        throw (@new Error "Expected to throw #(expected error)")
