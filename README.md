# bubble-boy

Modifies JavaScript code to sandbox all global variable declarations and references to avoid scope leaking. Resulting function should be executed in the sandboxing scope `(function() { ... })()` kind of function.

[![Dependency status](https://david-dm.org/alexgorbatchev/bubble-boy.png)](https://david-dm.org/alexgorbatchev/bubble-boy) [![Build Status](https://travis-ci.org/alexgorbatchev/bubble-boy.png)](https://travis-ci.org/alexgorbatchev/bubble-boy)

## Support

Please help me spend more time developing and maintaining awesome modules like this by donating!

The absolute best thing to do is to sign up with [Gittip](http://gittip.com) if you haven't already and donate just $1 a week. That is roughly a cup of coffee per month. Also, please do donate to many other amazing open source projects!

[![Gittip](http://img.shields.io/gittip/alexgorbatchev.png)](https://www.gittip.com/alexgorbatchev/)
[![PayPayl donate button](http://img.shields.io/paypal/donate.png?color=yellow)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PSDPM9268P8RW "Donate once-off to this project using Paypal")

## Installation

    npm install bubble-boy

## Testing

    npm test

## Using

    var bubbleBoy = require('bubble-boy');

    bubbleBoy("i = 1")
    // sandbox.i = 1

## Implementation Details

    log("hello")
    // sandbox.log("hello")

    console.log("hello")
    // sandbox.console.log("hello")

    i = 10
    // sandbox.i = 10

    i++
    // sandbox.i++

    first.second.third = 10
    // sandbox.first.second.third = 10

    function f(foo) { foo = 10; }
    // foo = 20;

    function f(foo) { foo = 10; }
    // sandbox.foo = 20;

    f = function() {};
    f("test");
    // sandbox.f = function() {};
    // sandbox.f("test");

    function f(foo) { foo = 10; }
    // function f(foo) { foo = 10; }

    function f(foo) {
      function b() {
        foo = 10;
      }
    }
    // function f(foo) {
    //   function b() {
    //     foo = 10;
    //   }
    // }

    function b() {
      f = function() {};
      f("test");
    }
    // function b() {
    //   sandbox.f = function() {};
    //   sandbox.f("test");
    // }

    function f(bar) {
      function localFunc() {}
      localFunc(bar);
    }
    // function f(bar) {
    //   function localFunc() {}
    //   localFunc(bar);
    // }

    function f(bar) { globalFunc(bar); }
    // function f(bar) { sandbox.globalFunc(bar); }

    var f = function() {};
    f("test");
    // sandbox.f = function() {};
    // sandbox.f("test");

## Other modules

* [jade-compiler](https://github.com/alexgorbatchev/jade-compiler)
* [stylus-compiler](https://github.com/alexgorbatchev/stylus-compiler)
* [coffee-compiler](https://github.com/alexgorbatchev/coffee-compiler)

## License

The MIT License (MIT)

Copyright (c) 2013 Alex Gorbatchev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
