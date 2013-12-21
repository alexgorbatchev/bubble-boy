require 'coffee-errors'

chai = require 'chai'

# explicitly use compiled version
bubbleBoy = require '../bubble-boy.js'

expect = chai.expect

describe 'bubble-boy', ->
  test = (src, expected) ->
    actual = bubbleBoy src
    expect(actual).to.equal expected

  describe 'matches', ->
    it 'undeclared function call', ->
      test """log("hello")""",
           """sandbox.log("hello")"""

    it 'undeclared property function call', ->
      test """console.log("hello")""",
           """sandbox.console.log("hello")"""

    it 'global variable declaration', ->
      test """i = 10""",
           """sandbox.i = 10"""

    it 'global variable reference', ->
      test """i++""",
           """sandbox.i++"""

    it 'object with deeply nested properties', ->
      test """first.second.third = 10""",
           """sandbox.first.second.third = 10"""

    it 'variable with the same name as prior argument', ->
      test """
        function f(foo) { foo = 10; }
        foo = 20;
      """, """
        function f(foo) { foo = 10; }
        sandbox.foo = 20;
      """

    it 'implicitly globaly declared functions', ->
      test """
        function b() {
          f = function() {};
          f("test");
        }
      """, """
        function b() {
          sandbox.f = function() {};
          sandbox.f("test");
        }
      """

  describe 'skips', ->
    it 'function arguments', ->
      test """function f(foo) { foo = 10; }""",
           """function f(foo) { foo = 10; }"""

    it 'nested function arguments', ->
      test """
        function f(foo) {
          function b() {
            foo = 10;
          }
        }
      """, """
        function f(foo) {
          function b() {
            foo = 10;
          }
        }
      """

    it 'locally declared functions', ->
      test """
        function f(bar) {
          function localFunc() {}
          localFunc(bar);
        }
      """, """
        function f(bar) {
          function localFunc() {}
          localFunc(bar);
        }
      """

    it 'locally declared variable functions', ->
      test """
        var f = function() {};
        f("test");
      """, """
        var f = function() {};
        f("test");
      """

