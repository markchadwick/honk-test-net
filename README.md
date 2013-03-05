Honk! Test Net!
=============
Some tools to help test browser-based network-y things in a headless
environmentment.


XMLHttpRequest
--------------
The underlying mock-thing-out-er-ator is based on Philipp von Weitershausen's
mock\_server.js impl. Seems to work well.

In a mocha or Jasmine environment, including this file will give you a @server
properly set up and torn down around all your tests.

Usage is as so:

```coffee
require 'honk-test-net/http_server'

describe 'Remote Pants Service', ->

  it 'should give me info on pants', (done) ->
    @server.when 'GET', '/pants', (req) ->
      status: 200
      body:   'Pants Found'
      
    $.get '/',
      success: (resp) ->
        expect(resp.data).to.equal 'Pants Found'
        done()
```
