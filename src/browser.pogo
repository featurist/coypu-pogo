http = require 'httpism'

Browser (port) =
    this.port = port
    this.selenium base url = "http://localhost:#(this.port)"
    this

Browser.prototype.selenium command url (command) =
    "#(this.session url)/#(command)"

Browser.prototype.selenium url (path) =
    "#(this.selenium base url)/#(path)"

Browser.prototype.selenium post! (command, body) =
    http.post! (self.selenium command url (command)) { body = JSON.stringify(body) }

Browser.prototype.open! =
    body = { desired capabilities = {} }
    response = http.post! (self.selenium url "session") { body = JSON.stringify(body) }
    self.session url = response.url
    self

Browser.prototype.close! =
    result = http.delete! (this.session url)
    self

Browser.prototype.visit! (url) =
    this.selenium post! 'url' { url = url }
    self

Browser.prototype.execute script! (script, args) =
    response = this.selenium post! 'execute' { script = script, args = args || [] }
    value = JSON.parse(response.body).value
    value

Browser.prototype.get selenium json! (command) =
    response = http.get! (self.selenium command url (command))
    JSON.parse(response.body).value

Browser.prototype.current url! =
    self.get selenium json! 'url'

Browser.prototype.source! =
    self.get selenium json! 'source'

Browser.prototype.status! =
    response = http.get! (self.selenium url 'status')
    JSON.parse(response.body).value

Browser.prototype.title! =
    response = http.get! (self.selenium command url 'title')
    response.body

exports.Browser = Browser

exports.open! (port: 9195) =
    browser = @new Browser(port)
    browser.open!
