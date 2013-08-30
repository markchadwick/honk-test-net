mockServer = require './mock_server'
dom        = require './dom'


class HttpServer
  constructor: ->
    @_patterns = []
    @window = global.window or {}
    @_server = new mockServer.MockHttpServer (req) =>
      @_handleRequest(req)

  when: (method, url, respond) ->
    @_patterns.push [method, url, respond]

  start: ->
    @_server.start(@window)

  stop: ->
    @_server.stop(@window)

  _handleRequest: (request) ->
    handed = false

    for [method, url, respond] in @_patterns
      if method is request.method and url is request.url
        resp = respond(request) or {}
        resp.status   or= 200
        resp.body     or= ''

        request.receive resp.status, resp.body
        handed = true

    unless handed
      request.receive 404, 'Not Found'

# If we're running in a mocha environment, set up and tear down @server for each
# test.
beforeEach? ->
  @server = new HttpServer(dom.window)
  @server.start()

afterEach? ->
  @server.stop()

module.exports = HttpServer
