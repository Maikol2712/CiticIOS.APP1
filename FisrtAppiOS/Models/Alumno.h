//
//  Alumno.h
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 23/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alumno : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, retain) NSURL *avatarUrl;
@property (nonatomic, strong) NSString *avatarString;

@end
