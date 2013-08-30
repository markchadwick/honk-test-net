jsdom         = require('jsdom').jsdom
LocalStorage  = require('localStorage')

global.document     or= jsdom()
global.window       or= document.createWindow()
global.navigator    or= global.window.navigator
global.localStorage or= LocalStorage

beforeEach ->
  LocalStorage.clear()

module.exports =
  document: global.document
  window:   global.window
