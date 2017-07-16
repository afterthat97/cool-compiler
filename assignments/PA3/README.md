# Cool Compiler - Parsing

Click **[here](https://masterliu.net/archives/763)** to view the Chinese version of this post.

I have used all the examples provided to test my parser and compared it with the referenced parser. The outputs of them are the same.

As for error handling, I modified `bad.cl` so it can exercise parsing errors in classes, features, a `let` binding, and an expression inside a `{...}` block. My parser can quickly recover from an error and detect more possible errors than the referenced parser.

Firstly you need to know the usage of yacc, which is a parser generator: 

* [Bison manual](http://www.gnu.org/software/bison/manual/html_node/index.html)
* [Basic usage of yacc (written in Chinese)](https://masterliu.net/archives/741)

The organization of files in this assignment is shown as follows:

![](https://img.masterliu.net/cool-compiler/Parser_en.png)

Cool syntax (Page 17 of the Cool manual):

![](https://img.masterliu.net/cool-compiler/cfg.jpg)

Inheritance of AST nodes (Each of the phyla is a class derived directly from `tree node`):

![](https://img.masterliu.net/cool-compiler/tree_node.png)

Precedence (from highest to lowest):
<pre>
.
@
~ 
isvoid
* /
+ -
<= < = 
not
<-
</pre>

All binary operations are left-associative, with the exception of assignment, which is right-associative, and the three comparison operations, which do not associate.

#### Write Parsing Rules

According to the definition of AST nodes in `cool-tree.aps`, you can write parsing rules easily in `cool.y`. For example, the definition of the constructor of `class` is as follows:

<pre>
constructor class_(name : Symbol; parent: Symbol;
    features : Features; filename : Symbol): Class_;
</pre>

The parsing rule is as follows:

<pre>
class    : CLASS TYPEID '{' feature_list '}' ';' {
            $$ = class_($2, idtable.add_string("Object"), 
                $4, stringtable.add_string(curr_filename));
        }
        | CLASS TYPEID INHERITS TYPEID '{' feature_list '}' ';' {
            $$ = class_($2, $4, $6,
                stringtable.add_string(curr_filename));
        }
        ;
</pre>

Attention that list phyla have a distinct set of operations for constructing and accessing lists. For each phylum named X there is a phylum called Xs (except for `Classes`, which is a list of Class nodes) of type List[X]. List functions are defined automatically for each list. 

The function `nil_***()` returns an empty list of type phylum. The function `single_***()` makes a list of length 1 out of its phylum argument. The function `append_***()` appends two lists of phylums. For the example of `formal_list`, whose type is `Formals`ï¼

<pre>
formal_list : {
                $$ = nil_Formals();
            }
            | formal {
                $$ = single_Formals($1);
            }
            | formal_list ',' formal {
                $$ = append_Formals($1, single_Formals($3));
            }
            ;
</pre>

When you have completed all the parsing rules in `cool.y`, type `make parser` to build the parser. Yacc produces a human-readable dump of the LALR(1) parsing tables in the `cool.output`. You can check whether your parser has any shift-reduce conflicts.

The Cool `let` construct introduces an ambiguity into the language. The manual resolves the ambiguity by saying that a `let` expression extends as far to the right as possible.

#### Error Handling

* If there is an error in a class definition but the class is terminated properly and the next class is syntactically correct, the parser should be able to restart at the next class definition.
* Similarly, the parser should recover from errors in features (going on to the next feature), a `let` binding (going on to the next variable), and an expression inside a `{...}` block.

So you should add the `error` pseudo-nontermina to the production of class, feature, and so on.
