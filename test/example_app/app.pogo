express = require 'express'

app = express()

app.get '/' @(req, res)
    res.end "<html><title>Home Page</title><body>Well, Hello<br /><a href='foo'>foo</a></body></html>"

app.get '/foo' @(req, res)
    res.end "<html><title>Foo Page</title><body>Foo!</body></html>"

module.exports = app