# Bubble Boy

Modifies JavaScript code to sandbox all global variable declarations and references.

[![Dependency status](https://david-dm.org/alexgorbatchev/bubble-boy.png)](https://david-dm.org/alexgorbatchev/bubble-boy) [![Build Status](https://travis-ci.org/alexgorbatchev/bubble-boy.png)](https://travis-ci.org/alexgorbatchev/bubble-boy)

## Installation

    npm install bubble-boy

## Tests

    npm test

## Usage Example

```javascript
var bubbleBoy = require('bubble-boy');

bubbleBoy("i = 1")
// sandbox.i = 1
```

## Implementation Details

```javascript
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

function f(bar) {
  function localFunc() {}
  localFunc(bar);
}
// function f(bar) {
//   function localFunc() {}
//   localFunc(bar);
// }

var f = function() {};
f("test");

// var f = function() {};
// f("test");
```

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
