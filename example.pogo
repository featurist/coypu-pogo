coypu = require './src/browser.pogo'

browser = coypu.open!

browser.visit! 'http://localhost:3003/'

browser.find css ('a').click!

console.log(browser.title!)

browser.close!