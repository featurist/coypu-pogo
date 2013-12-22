http = require 'httpism'

selenium wire protcol resource (url) =
    res = http.resource (url)
    res := res.with response body parser ('application/json; charset=utf-8', JSON.parse)
    res := res.with request body formatter (JSON.stringify)
    res

Browser (port) =
    this.selenium = selenium wire protcol resource "http://localhost:#(port)"
    this

Browser.prototype = {

    open! =
        body = { desired capabilities = {} }
        self.session resource = self.selenium.post! 'session' { body = body }
        self.session = selenium wire protcol resource "#(self.session resource.url)/"
        self

    selenium post! (command, body) =
        self.session.post! (command) { body = body }

    close! =
        self.session resource.delete!
        self

    visit! (url) =
        self.selenium post! 'url' { url = url }
        self

    execute script! (script, args) =
        self.selenium post! 'execute' { script = script, args = args || [] }.body.value

    current url! =
        self.session.get! 'url'.body.value

    source! =
        self.session.get! 'source'.body.value

    status! =
        self.selenium.get! 'status'.body.value

    title! =
        self.session.get! 'title'.body.value

}

exports.Browser = Browser

exports.open! (port: 9195) =
    browser = @new Browser(port)
    browser.open!
