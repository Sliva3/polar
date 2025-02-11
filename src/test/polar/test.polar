juse 'com\slavlend\Abc.class'
use 'lib.console'
use 'lib.strings'
use 'lib.math'
use 'lib.base64'
use 'lib.crypto'

func hello_world_test() = {
    put('Hello World!')
    put('Test passed')
}

func variable_test() = {
    a = 1
    assert (a == 1)
    put('Test passed')
}

func for_statement_continue_test() = {
    value = 0

    for (i = 0, i < 5) {
        if (i == 4) {
            i += 1
            next
        }

        value += 1
        i += 1
    }

    assert(value == 4)
    put('Test passed')
}

func if_test() = {
    a = 5
    b = 4 + 1

    if ((a == b)) {
        put('Test passed')
    }
    else {
        assert(1 == 2)
    }
}

func each_statement() = {
    lst = [5, 3, 1]
    each (elem, lst) {
        next
    }
    put('Test passed')
}

func nested_test() = {
    total_sum = 0

    lst = [1, 2, 3]
    each (outer, lst) {
        if (outer == 2) {
            next
        }
        for (i = 0, i < 5) {
            if (i == 4) {
                break
            }
            inner_sum = 0
            number = 0
            while (number < i) {
                number = number + 1
                inner_sum = inner_sum + number
            }

            total_sum = total_sum + inner_sum
            i += 1
        }
    }

    assert(total_sum == 20)
    put('Test passed')
}

func while_test() = {
    index = 0

    while (index < 5) {
        index += 1
    }

    assert(index == 5)
    put('Test passed')
}

func optimization_test() = {
    a = 2 + 2 * 2

    assert(a == 6)
    put('Test passed')
}

func float_math_test() = {
    a = 5.1122324
    a = a + 1.78

    assert(a == 6.892232)
    put('Test passed')
}

class A()  = {
    func init() = {
        put('Test passed')
    }
}

func len_test() = {
    length = len('aaaa')
    assert(length == 4)
    put('Test passed')
}

func juse_test() = {
    reflected = reflect 'com.slavlend.Abc' []
    assert(reflected.testRuntimeJuse() == 'Juse works perfect!')
}

func infinity_test() = {
    assert(1 / 0 == Math.Infinity)
    assert(-1 / 0 == Math.NegativeInfinity)
    assert(Math.Infinity > 1000)
    assert(Math.NegativeInfinity < -1000)

    assert(Math.Infinity + 1000 == Math.Infinity)
    assert(Math.Infinity - 1000 == Math.Infinity)
    assert(Math.Infinity * 2 == Math.Infinity)
    assert(Math.Infinity / 2 == Math.Infinity)

    assert(Math.NegativeInfinity + 1000 == Math.NegativeInfinity)
    assert(Math.NegativeInfinity - 1000 == Math.NegativeInfinity)
    assert(Math.NegativeInfinity * 2 == Math.NegativeInfinity)
    assert(Math.NegativeInfinity / 2 == Math.NegativeInfinity)

    assert(Math.Infinity + Math.NegativeInfinity != Math.NaN)
    assert(Math.NegativeInfinity + Math.Infinity != Math.NaN)
    assert(Math.Infinity - Math.Infinity != Math.Infinity)
    assert(Math.NegativeInfinity - Math.NegativeInfinity != Math.NegativeInfinity)

    assert(0 / 0 != 0 / 0)
    assert((0 / 0 > 0 or 0 / 0 < 0) == false)
    put('Test passed')
}

func lambda_test() = {
    a = lambda(x) -> {
        return('hello world')
    }

    assert(a('name') == 'hello world')
    put('Test passed')
}

func test_repeat() = {
    a = 0
    repeat(15) {
        a += 1
    }
    assert(a == 15)
    put('Test passed')
}

func math_module_test() = {
    assert(Math.sin(10) == -0.5440211)
    assert(Math.cos(10) == -0.8390715)
    put('Test passed')
}

func nested_function_test() = {
    func inside() = {
        func inside_inside() = {
            return(123)
        }
        return(inside_inside)
    }
    fn = inside()
    assert(fn() == 123)
    put('Test passed')
}

func ternary_test() = {
    a = 1 == 1 ? 'yes' : 'no'
    assert(a == 'yes')
    put('Test passed')
}

func closures_test() = {
    a = 3
    func test() = {
        assert(a == 3)
            put('Closure test passed!')
    }
    return(test)
}

func closures_test_2() = {
    a = 3
    func inner() = {
        b = 4
        func inner_inner() = {
            assert(a*b == 12)
            put('Closure test passed!')
        }
        return(inner_inner)
    }
    return(inner)
}

func lambda_closure_test() = {
    e = 3
    a = lambda(x) -> {
        return('hello world: ' + string(e))
    }

    assert(a('name') == 'hello world: 3.0')
    put('Lambda closure test passed!')
}

func strings_test() = {
    a = Strings.replace('Test hello', 'hello', 'passed')
    assert(a == 'Test passed')
    put(a)
}

func formatting_test() = {
    b = Strings.format('Hello {0.0}', ['world!'])
    assert(b == 'Hello world!')
    put('Test passed')
}
func base64() {
    text = 'hi'
    text_bytes = Base64.to_bytes(text)
    encoded = Base64.encode(text_bytes)
    decoded = Base64.decode(encoded)
    str = Base64.to_string(decoded)
    put('Base64 passed')
}
func aes() {
    str = 'hello'
    encrypted = Crypto.encryptAES(str,'123456789X123456')
    decrypted = Crypto.decryptAES(encrypted,'123456789X123456')
    put('AES passed')
}
hello_world_test()
variable_test()
for_statement_continue_test()
if_test()
each_statement()
nested_test()
while_test()
optimization_test()
float_math_test()
len_test()
juse_test()
infinity_test()
lambda_test()
test_repeat()
math_module_test()
nested_function_test()
ternary_test()
# closure 1 #
closure_1 = closures_test()
# put(closure_1)#
closure_1()
# closure 2 #
closure_2 = closures_test_2()
closure_3 = closure_2()
# put(closure_3) #
closure_3()
lambda_closure_test()
strings_test()
formatting_test()
base64()
aes()
