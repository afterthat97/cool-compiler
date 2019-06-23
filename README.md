# Stanford CS1/CS143 Compilers Course Project - Cool

Stanford online course of CS143 Compilers: **[Link](https://lagunita.stanford.edu/courses/Engineering/Compilers/Fall2014/info)**

## Introduction

The full name of "Cool" is "The Classroom Object-Oriented Language". It is a small language designed for use in an undergraduate compiler course project by Stanford University. Cool has many of the features of modern programming languages, including objects, automatic memory management, and strong static typing. It generates code for a MIPS simulator.

More info:

* [The Cool Reference Manual](http://web.stanford.edu/class/cs143/materials/cool-manual.pdf)
* [A Tour of the Cool Support Code](http://web.stanford.edu/class/cs143/materials/cool-tour.pdf)
* [The Cool Runtime System](http://web.stanford.edu/class/cs143/materials/cool-runtime.pdf)
* [Flex manual](http://westes.github.io/flex/manual/)
* [Bison manual](http://www.gnu.org/software/bison/manual/html_node/index.html)

## Installing & Setup

There are two ways to configure the environment. One is to use the provided pre-configured Linux system via VirtualBox VM, the other is to install directly on your own installation of Linux (Debian-based system required). I prefer the second choice because the download is only 5.5MB, otherwise you would need to download the whole VM image which is over 700MB.

## Assignments

* PA2 - Lexical Analysis: **Done**
* PA3 - Parsing: **Done**
* PA4 - Semantic Analysis: **Done**
* PA5 - Code Generation: **Skipped**

## Troubleshooting

### spim: No such file or directory

This is because you are running a 64-bit linux, which does not have the 32-bit libc installed.

For Ubuntu 16.04, you can fix it with:

```
sudo apt-get install libc6-i386
```

### libfl.so: undefined reference to 'yylex'

* Set the line `%option noyywrap` in the `cool.flex` file
* Remove the `-lfl` part of the `LIB=` line in the makefile
