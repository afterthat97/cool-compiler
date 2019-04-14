class Base {
    a: Int;
    b: Int;
    add(x: Int, y: Int) : Int {
        {
            a <- x;
            b <- y;
            a + b;
        }
    };
};

class D1 inherits Base {
    add(x: Bool, y: Int) : Int {
        {
            a <- x;
            b <- y;
            a - b;
        }
    };
};

class D2 inherits Base {
    add(x: Int, y: Int, z: Int) : Int {
        {
            a <- x;
            b <- y;
            a - b;
        }
    };
};

class D3 inherits Base {
    add(x: Int, y: Int) : Bool {
        {
            a <- x;
            b <- y;
            a - b;
            true;
        }
    };
};


class Main {
    main(): Int {
        {
            0;
        }
    };
};
