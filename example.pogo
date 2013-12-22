coypu = require './src/browser.pogo'

browser = coypu.open!

browser.visit! 'http://www.google.com/'

console.log(browser.title!)

browser.close!