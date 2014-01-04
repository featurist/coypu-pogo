Browser = require './drivers/selenium/driver'

exports.Browser = Browser

exports.open! (port: 9515) = (@new Browser(port)).open!
