Node (browser, selector) =
    this.browser = browser
    this.selector = selector
    this

Node.prototype = {

    click! =
        options = { using = 'css selector', value = (self.selector) }
        element = self.browser.in session.post! "element" { body = options }
        self.browser.in session.post! "element/#(element.body.value.ELEMENT)/click"

}

module.exports = Node