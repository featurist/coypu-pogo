child process = require 'child_process'
chromedriver = require '../src/chromedriver'
path = require 'path'

describe '/example.pogo'

    chrome = nil
    app server = nil

    before
        app server := run example app!
        chrome := chromedriver.start!

    after
        chrome.stop!
        app server.kill()

    it 'executes'
        this.timeout 5000
        result = run example!
        result.out.should.equal "Foo Page\n"
        result.err.should.equal ''
        result.status.should.equal 0


run example (ran) =
    example = path.resolve (__dirname, "../example.pogo")

    child = child process.spawn ('pogo') [example]

    out = ''
    err = ''

    child.stdout.on 'data' @(data)
        out := out + data.to string()

    child.stderr.on 'data' @(data)
        err := err + data.to string()

    child.on 'exit' @(status)
        ran (null) {
            status = status
            out = out
            err = err
        }

    true

run example app (started) =
    example = path.resolve (__dirname, "example_app/server.pogo")

    child = child process.spawn ('pogo') [example]

    out = ''
    err = ''

    child.stdout.once 'data' @(data)
        started (null, child)

    child.stdout.on 'data' @(data)
        out := out + data.to string()

    child.stderr.on 'data' @(data)
        err := err + data.to string()

    child.on 'exit' @(status)
        console.log("APP SERVER EXITED WITH STATUS #(status)\nSTDOUT\n#(out)\nSTDERR\n#(err)")

    true
