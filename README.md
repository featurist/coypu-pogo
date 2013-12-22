# Coypu-pogo

Intuitive, [robust](http://github.com/featurist/coypu) browser automation for [PogoScript](http://github.com/featurist/pogoscript)

### Work in progress!

Coypu-pogo is just getting started. There are a few [tests](./test) but that's about it. Get involved!


### Example

    coypu = require 'coypu-pogo'

    browser = coypu.open!

    browser.visit! 'http://www.google.com/'

    console.log(browser.title!)

    browser.close!
