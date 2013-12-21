http = require 'httpism'
fs = require 'fs'
chromedriver = require '../src/chromedriver'

describe 'chromedriver'

    proc = nil
    log path = nil

    should be running on port! (port) =
        http.get! "http://localhost:#(port)/zomg".body.should.eql 'unknown command: zomg'

    should be logging to! (log file) =
        fs.read file! (log file).should.exist

    describe 'with no options'

        before
            proc := chromedriver.start!
            log path := './chromedriver.log'

        after
            proc.kill()
            fs.unlink! (log path)

        it 'starts on port 9195'
            should be running on port! 9195

        it 'writes logs to ./chromedriver.log'
            should be logging to! './chromedriver.log'

    describe 'with port 9197 specified'

        before
            proc := chromedriver.start! { port = 9197 }
            log path := './chromedriver.log'

        after
            proc.kill()
            fs.unlink! (log path)

        it 'starts on port 9197'
            should be running on port! 9197

        it 'writes logs to ./chromedriver.log'
            should be logging to! './chromedriver.log'

    describe 'with port 9198 and ./zomg.log specified'

        before
            log path := './zomg.log'
            proc := chromedriver.start! { port = 9198, log path = log path }

        after
            proc.kill()
            fs.unlink! (log path)

        it 'starts on port 9198'
            should be running on port! 9198

        it 'writes logs to ./zomg.log'
            should be logging to! './zomg.log'
