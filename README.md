# Stanford CS1/CS143 Compilers Course Project - Cool

Click **[here](https://masterliu.net/archives/768)** to view the Chinese version of this post.

Entry to Stanford online Compilers course: **[Link](https://lagunita.stanford.edu/courses/Engineering/Compilers/Fall2014/info)**






#### Introduction

The full name of "Cool" is "The Classroom Object-Oriented Language". It is a small language designed for use in an undergraduate compiler course project by Stanford University. Cool has many of the features of modern programming languages, including objects, automatic memory management, and strong static typing. It generates code for a MIPS simulator.

More info:

* [The Cool Reference Manual](http://web.stanford.edu/class/cs143/materials/cool-manual.pdf)
* [A Tour of the Cool Support Code](http://web.stanford.edu/class/cs143/materials/cool-tour.pdf)
* [The Cool Runtime System](http://web.stanford.edu/class/cs143/materials/cool-runtime.pdf)







#### Installing & Setup

There are two ways to configure the environment. One is to use the provided pre-configured Linux 
system via VirtualBox VM, the other is to install directly on your own installation of Linux (Debian-based system required). I prefer the second choice because the download is only 5.5MB, otherwise you would need to download the whole VM image which is over 700MB.







#### First Things First

If you wanna start this project, firstly you need to master Unix / Linux Shell. Besides, you need to know the usage of common Unix programming tools, including G++, GCC, make, Flex, yacc and so on. (Flex is a fast lexical analyser generator, and yacc is a parser generator)

More info: 

* [Unix Programming Tools](https://res.masterliu.net/pdf/UnixProgrammingTools.pdf)
* [Flex manual](http://westes.github.io/flex/manual/)
* [Bison manual](http://www.gnu.org/software/bison/manual/html_node/index.html)
* [Basic usage of Flex (written in Chinese)](https://masterliu.net/archives/720)
* [Basic usage of yacc (written in Chinese)](https://masterliu.net/archives/741)







#### PA2: Lexical Analysis

Lexical analysis is the first phase of a compiler. The lexical analyzer breaks the source code into a series of tokens, and passes the data to the parser when it demands.

Completed. Details can be found in this post: [Cool Compiler - Lexical Analysis](https://masterliu.net/archives/774)







#### PA3: Parsing

Parsing (or syntax analysis) is the second phase of a compiler. A  parser takes the input from a lexical analyzer in the form of token streams and analyzes the source code (token stream) against the production rules to detect any errors in the code. The output of this phase is an abstract syntax tree (AST).

Completed. Details can be found in this post: [Cool Compiler - Parsing](https://masterliu.net/archives/777)







#### PA4: Semantic Analysis

Not done yet.







#### PA5: Code Generation

Not done yet.
