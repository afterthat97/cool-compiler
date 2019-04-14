class C inherits IO {
    init(): Int {
        {
            0;
        }
    };
};

Class Main {
    a : A;
    c : C;
    main() : Int {
	    {
            a@Object.type_name();
            a@AAA.hhh();
            c@IO.out_string("123");
            c@AAA.hhh();
            a.hhh();
            c.hhh();
            0;
        }
	};
};
