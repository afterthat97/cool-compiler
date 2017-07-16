# Cool Compiler - Lexical Analysis

Click **[here](https://masterliu.net/archives/714)** to view Chinese version of this post.

I have used all the examples provided to test my lexer and compared it with the referenced lexer. The outputs of them are the same.

Firstly you need to know the usage of Flex, which is a fast lexical analyser generator: 

* [Flex manual](http://westes.github.io/flex/manual/)
* [Basic usage of Flex (written in Chinese)](https://masterliu.net/archives/720)

The organization of files in this assignment is shown as follows:

![](https://img.masterliu.net/cool-compiler/Lexer_en.png)

Requirement:






#### White Space

White space consists of any sequence of the characters: blank (ascii 32), `\n` (newline, ascii 10), `\f` (form feed, ascii 12), `\r` (carriage return, ascii 13), `\t` (tab, ascii 9), `\v` (vertical tab, ascii 11).

All these charaters are ignored except for the newline charater: `\n`, which is needed for counting line numbers.






#### Comments

There are two forms of comments in Cool. Any characters between two dashes `--` and the end of this line are treated as comments (just like `//` in C). Comments may also be written by enclosing text in `(*`...`*)` (just like `/*` and `*/` in C). The latter form of comment may be nested. Comments cannot cross file boundaries.

* Comments should be ignored.
* If a comment remains open when EOF is encountered, report this error with the message "EOF in comment".
* If you see  `*)`  outside a comment, report this error as "Unmatched *)", rather than tokenizing it as `*` and `)`.






#### Operators & Separator

Return itself as a `char` if it is a single-charater operator or Separator. As for the others with two charaters, return the value as it is defined in `cool-parse.h`. 






#### Keywords

The keywords of cool are: `class`, `else`, `false`, `fi`, `if`, `in`, `inherits`, `isvoid`, `let`, `loop`, `pool`, `then`, `while`, `case`, `esac`, `new`, `of`, `not`, `true`. Except for the constants `true` and `false`, keywords are case insensitive. To conform to the rules for other objects, the first letter of `true` and `false` must be lowercase; the trailing letters may be upper or lower case.






#### Strings

The type `Char` is invalid in cool. Single charater and string both should be defined as `String`. Strings are enclosed in double quotes `"`...`"`.

* If an EOF is encountered before the close-quote, report this error as "EOF in string constant".
* When a string is too long (exceed `MAX_STR_CONST`), report the error as "String constant too long".
* You must return an error as "String contains null character" for a string containing
the literal null character. However, the sequence of two characters `\` `0` is allowed but should be converted to the one character `\0`, which represents the null charater.
* Your scanner should convert escape characters in string constants to their correct values.
* If a string contains an unescaped newline, report that error as "Unterminated string constant" and resume lexing at the beginning of the next line. 

Example of one invlid expression:

<pre>
//Invalid
str = "123
456";
</pre>

The valid expression should be as follows:

<pre>
//Valid
str = "123\n456";
</pre>

This is also valid: 

<pre>
//Valid
str = "123\
	   456";
</pre>






#### Integers

Integers are non-empty strings of digits 0-9.






#### Identifiers

Identifiers are strings (other than keywords) consisting of letters, digits, and the underscore character. Type identifiers begin with a capital letter; object identifiers begin with a lower case letter. There are two other identifiers, self and SELF TYPE that are treated specially by Cool but are not treated as keywords.






#### Others

Just return an error with this token.
