http = require 'httpism'

selenium resource (url) =
    res = http.resource (url)
    res := res.with response body parser ('application/json; charset=utf-8', JSON.parse)
    res := res.with request body formatter (JSON.stringify)
    res

Browser (port) =
    this.selenium = selenium resource "http://localhost:#(port)"
    this

Browser.prototype = {

    open! =
        body = { desired capabilities = {} }
        self.session = self.selenium.post! 'session' { body = body }
        self.in session = selenium resource "#(self.session.url)/"
        self

    close! =
        self.session.delete!
        self

    status! =
        self.selenium.get! 'status'.body.value

    visit! (url) =
        self.in session.post! 'url' { body = { url = url } }
        self

    execute script! (script) =
        options = { script = script, args = [] }
        self.in session.post! 'execute' { body = options }.body.value

    current url! =
        self.in session.get! 'url'.body.value

    source! =
        self.in session.get! 'source'.body.value

    title! =
        self.in session.get! 'title'.body.value

}

exports.Browser = Browser

exports.open! (port: 9195) =
    browser = @new Browser(port)
    browser.open!
