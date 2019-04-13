class C {
	a : Int <- true;
	b : Bool;
	init(x : Int, x : Bool, self : Int) : C {
        {
		    a <- x;
		    b <- y;
		    self;
        }
	};
    test(x : Innt) : Sttring {
        {
            "123";
        }
    };
    test(): String {
        {
            "456";
        }
    };
    test2(): Bool {
        {
            4;
        }
    };
    test3(): Int {
        {
            hhh <- 1;
        }
    };
    test4(): Int {
        {
            if 3 then 0 else 1 fi;
            
            while 3 loop 0 pool;
            
            case 3 of
                a: Int => { 0; };
                b: Int => { 0; };
            esac;
            
            let a: Int <- true in 0;

            new HHH;

            0;
        }
    };
    test5(): Int {
        {
            1 + 1;
            1 + false;
            true + true;
            a <- 1 - true;
            1 * "123";
            1 / false;
            ~false;
            false < true;
            1 < 2;
            "1" < "2";
            1 = "123";
            1 = 1;
            1 <= 2;
            "1" <= "2";
            true = false;
            true = 1;
            not false;
            not 1;
            not "123";
            0;
        }
    };
};

Class Main {
    main() : Int {
	    {
            (new C)@IO.type_name();
            (new C)@Object.typename();
            (new C)@Object.type_name();
            0;
        }
	};
};
