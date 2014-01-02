express = require 'express'

app = express()

app.get '/' @(req, res)
    res.end "<html><title>Home Page</title><body>Well, Hello</body></html>"

module.exports = app