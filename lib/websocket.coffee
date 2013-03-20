

class MockWebsocket
  constructor: (@path, window) ->
    @window     = window or global.window
    @readyState = 1

  close: ->


beforeEach? ->
  @_wsOrigWindow = global.window or {}
  websockets = {}

  @websocketByPath = (path) ->
    websockets[path] or []

  @websocket = (path) ->
    websocket = new MockWebsocket(@window, path)
    (websockets[path] or= []).push(websocket)
    websocket

  @_origWebsocket = @_wsOrigWindow.WebSocket
  @_wsOrigWindow.WebSocket = MockWebsocket

afterEach? ->
  @_wsOrigWindow.WebSocket = @_origWebsocket
