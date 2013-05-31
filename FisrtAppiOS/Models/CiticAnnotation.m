//
//  CiticAnnotation.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 30/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//

#import "CiticAnnotation.h"

@implementation CiticAnnotation

- (NSString *)title {
    return @"Citic Research";
}

- (NSString *)subtitle {
    return @"Centro de investigación";
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(43.332676, -8.408070);
}

@end
