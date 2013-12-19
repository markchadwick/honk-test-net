{HttpServer} = require './index'


# If we're running in a mocha environment, set up and tear down @server for each
# test.
beforeEach? ->
  @server = new HttpServer
  @server.start()

afterEach? ->
  @server.stop()

module.exports = HttpServer
