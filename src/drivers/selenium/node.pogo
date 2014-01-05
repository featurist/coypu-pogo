errors = require '../../errors'

Node (browser, strategy, selector) =
    this.browser = browser
    this.strategy = strategy
    this.selector = selector
    this

Node.prototype = {

    click! =
        options = { using = self.strategy, value = self.selector }
        element = self.browser.in session.post! "element" { body = options }
        if (element.body.value.ELEMENT)
            self.browser.in session.post! "element/#(element.body.value.ELEMENT)/click"
        else
            throw (errors.Element Not Found (self.selector, self.strategy))

}

module.exports = Node