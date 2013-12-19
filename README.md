Honk! Test Net!
=============
Some tools to help test browser-based network-y things in a headless
environment.


XMLHttpRequest
--------------
The underlying mock-thing-out-er-ator is based on Philipp von Weitershausen's
mock\_server.js impl. Seems to work well.

In a Mocha or Jasmine environment, including this file will give you a @server
properly set up and torn down around all your tests.

Usage in Mocha or Jasmine is as so:

```coffee
require 'honk-test-net/lib/http_server'

describe 'Remote Pants Service', ->

  it 'should give me info on pants', (done) ->
    @server.when 'GET', '/pants', (req) ->
      status: 200
      body:   'Pants Found'

    $.get '/pants',
      success: (resp) ->
        expect(resp.data).to.equal 'Pants Found'
        done()
```

In another test environment that doesn't implement a beforeEach/afterEach, you
can instantiate an instance like, passing your DOM window as an argument.
Here's a qunit example.

```coffee
jsdom = require('jsdom').jsdom
global.document or= jsdom()
global.window   or= global.document.createWindow()

HttpServer = require 'honk-test-net/lib/http_server'


asyncTest 'Remote Pants Service', ->
  server = new HttpServer(global.window)
  server.when 'GET', '/pants', (req) ->
    status: 200
    body:   'Pants Found'

  $.get '/pants',
    success: (resp) ->
      equal(resp.data, 'Pants Found', 'Got those pants.')
      start()

```


Build status
------------
[![Build Status](https://secure.travis-ci.org/markchadwick/honk-test-net.png)](http://travis-ci.org/markchadwick/honk-test-net)
