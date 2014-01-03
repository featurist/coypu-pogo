child process = require 'child_process'
chromedriver = require '../src/chromedriver'
path = require 'path'

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

describe '/example.pogo'

    proc = nil

    before
        proc := chromedriver.start!

    after
        proc.stop!

    it 'executes'
        this.timeout 5000
        result = run example!
        result.out.should.equal ''
        result.err.should.equal ''
        result.status.should.equal 0
