expect = require('chai').expect

honkTestNet = require '../lib/http_server'


describe 'Test HTTP Server', ->

  beforeEach ->
    @makeRequest = (verb, url, callback) ->
      ajax = new @server.window.XMLHttpRequest()
      ajax.onreadystatechange = ->
        if ajax.readyState is 4
          callback(ajax)
      ajax.open(verb, url, true)
      ajax.send(null)

  it 'should have @server set for all tests', ->
    expect(@server).to.exist

  it 'should intercept server calls', (done) ->
    @server.when 'GET', '/pants', (req) ->
      status: 200
      body:   'Pants found'

    ajax = new @server.window.XMLHttpRequest()

    ajax.onreadystatechange = ->
      if ajax.readyState is 4
        expect(ajax.status).to.equal 200
        expect(ajax.responseText).to.equal 'Pants found'
        done()

    ajax.open('GET', '/pants', true)
    ajax.send(null)

  it 'should 404 when requesting an unmatched page', (done) ->
    @server.when 'GET', '/known', (req) ->
      body: 'Ok!'

    @makeRequest 'GET', '/known', (ajax) ->
        expect(ajax.status).to.equal 200
        expect(ajax.responseText).to.equal 'Ok!'

    @makeRequest 'GET', '/unknown', (ajax) ->
        expect(ajax.status).to.equal 404
        done()

  it 'should 404 when requesting an umatched method', (done) ->
    @server.when 'GET', '/get-only', (req) ->
      status: 200
      body:   'Ok!'

    @makeRequest 'POST', '/get-only', (ajax) ->
        expect(ajax.status).to.equal 404
        done()

