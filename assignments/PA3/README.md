# PA3: Parsing

I have used all the examples provided to test my parser and compared it with the referenced parser, the outputs of them are same.

As for error handling, I modified `bad.cl` so it can exercise parsing errors in classes, features, a `let` binding, and an expression inside a `{...}` block. My parser can quickly recover from an error and detect more possible errors than the referenced parser.

The source code is in `cool.y`, type `make parser` to build.
