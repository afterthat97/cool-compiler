
(*
 *  execute "coolc bad.cl" to see the error messages that the coolc parser
 *  generates
 *
 *  execute "myparser bad.cl" to see the error messages that your parser
 *  generates
 *)

(* no error *)
class A {
};

Class A inherits B {
	a : Int <- 0;
	test() : Int {
		let i : int <- 1, j : string in i
	};
	test2() : int { 1 };
	test3() : Int {
		{
			a = Double + a;
			C = a + 5;
			a * 2;
			Int;
		}
	};
	test4( : Int;
};

(* error:  a is not a type identifier *)
Class C inherits a {
};

(* error:  keyword inherits is misspelled *)
Class D inherts A {
};

(* error:  closing brace is missing *)
Class E inherits A {
;

