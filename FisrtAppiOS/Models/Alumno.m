//
//  Alumno.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 23/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//

#import "Alumno.h"

@implementation Alumno

@synthesize name, lastname, city, email, avatarUrl, avatarString;

- (id)initWithCoder:(NSCoder *)coder {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    // self = [super init]; en caso de no ser un KeyedArchive
    
    self = [[Alumno alloc] init];
    
    if (self) {
        name = [coder decodeObjectForKey:@"name"];
        lastname = [coder decodeObjectForKey:@"lastname"];
        city = [coder decodeObjectForKey:@"city"];
        email = [coder decodeObjectForKey:@"email"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:lastname forKey:@"lastname"];
    [coder encodeObject:city forKey:@"city"];
    [coder encodeObject:email forKey:@"email"];
}


@end
