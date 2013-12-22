http = require 'httpism'

Browser (port) =
    this.selenium resource = http.resource "http://localhost:#(port)"
    this

Browser.prototype.open! =
    body = { desired capabilities = {} }
    response = self.selenium resource.post! 'session' { body = JSON.stringify(body) }
    self.session url = response.url
    self.session resource = http.resource "#(response.url)/"
    self

Browser.prototype.selenium post! (command, body) =
    self.session resource.post! (command) { body = JSON.stringify(body) }

Browser.prototype.close! =
    self.session resource.delete! (self.session url)
    self

Browser.prototype.visit! (url) =
    self.selenium post! 'url' { url = url }
    self

Browser.prototype.execute script! (script, args) =
    response = self.selenium post! 'execute' { script = script, args = args || [] }
    JSON.parse(response.body).value

Browser.prototype.get selenium json! (command) =
    response = self.session resource.get! (command)
    JSON.parse(response.body).value

Browser.prototype.current url! =
    self.get selenium json! 'url'

Browser.prototype.source! =
    self.get selenium json! 'source'

Browser.prototype.status! =
    response = self.selenium resource.get! 'status'
    JSON.parse(response.body).value

Browser.prototype.title! =
    response = self.session resource.get! 'title'
    response.body

exports.Browser = Browser

exports.open! (port: 9195) =
    browser = @new Browser(port)
    browser.open!
