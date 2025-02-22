use 'lib.coroutines'

Coroutines.start_coro_loop()

repeat (10) {
    Coroutines.run(lambda()->{
        put('before')
        raise(1)
        put('after')
    })
}

Coroutines.end_coro_loop()