jsdom         = require('jsdom').jsdom
LocalStorage  = require('localStorage')

global.document     or= jsdom()
global.window       or= document.createWindow()
global.localStorage or= LocalStorage

beforeEach ->
  LocalStorage.clear()

module.exports = global.document
