//
//  main.swift
//  callSwiftFromC
//
//  Created by Boris Bügling on 05/02/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

@asmname("executeFunction") func executeFunction(fp: CFunctionPointer<()->()>)

func greeting() {
    println("Hello from Swift")
}

/*let p = UnsafeMutablePointer<()->()>.alloc(1)
p.initialize(greeting)
let cp = COpaquePointer(p)
let fp = CFunctionPointer<()->()>(cp)
executeFunction(fp)*/

private struct function_trampoline {
    private var trampoline_ptr: COpaquePointer
    var function_obj_ptr: UnsafeMutablePointer<function_obj>

    init(prototype: function_trampoline, new_fp: COpaquePointer) {
        trampoline_ptr = prototype.trampoline_ptr

        function_obj_ptr = UnsafeMutablePointer<function_obj>.alloc(1)
        let fobj = function_obj(prototype: prototype.function_obj_ptr.memory, new_fp: new_fp)
        function_obj_ptr.initialize(fobj)
    }
}

private struct function_obj {
    private var some_ptr_0: COpaquePointer
    private var some_ptr_1: COpaquePointer
    var function_ptr: COpaquePointer

    init(prototype: function_obj, new_fp: COpaquePointer) {
        some_ptr_0 = prototype.some_ptr_0
        some_ptr_1 = prototype.some_ptr_1
        function_ptr = new_fp
    }
}

private let trampoline = unsafeBitCast(greeting, function_trampoline.self)
let fp = CFunctionPointer<()->()>(trampoline.function_obj_ptr.memory.function_ptr)
executeFunction(fp)
