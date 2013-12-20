mockServer = require './mock_server'
dom        = require './dom'


class HttpServer
  constructor: (window) ->
    @_patterns = {}
    @window = window or dom.window
    @_server = new mockServer.MockHttpServer (req) =>
      @_handleRequest(req)

  when: (method, url, respond) ->
    @_patterns[url] or= {}
    @_patterns[url][method] = respond

  start: ->
    @_server.start(@window)

  stop: ->
    @_server.stop(@window)

  _handleRequest: (request) ->
    handed = false

    if @_patterns[request.url]? and @_patterns[request.url][request.method]?
      respond = @_patterns[request.url][request.method]
      resp = respond(request) or {}
      resp.status   or= 200
      resp.body     or= ''

      request.receive resp.status, resp.body
      handed = true

    unless handed
      request.receive 404, 'Not Found'


module.exports =
  HttpServer: HttpServer
