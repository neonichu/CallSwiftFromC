//
//  Func.c
//  callSwiftFromC
//
//  Created by Boris Bügling on 05/02/15.
//  Copyright (c) 2015 Boris Bügling. All rights reserved.
//

void executeFunction(void(*f)(void)) {
    f();
}
