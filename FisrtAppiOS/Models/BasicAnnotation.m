//
//  BasicAnnotation.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 30/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//

#import "BasicAnnotation.h"

@implementation BasicAnnotation

- (id)initWithTitle:(NSString *)aTitle
           subtitle:(NSString *)aSubtitle
     andCoordinates:(CLLocationCoordinate2D)aCoordinate {
    
    self = [super init];
    
    if (self) {
        _title = aTitle;
        _subtitle = aSubtitle;
        _coordinate = aCoordinate;
    }
    
    return self;
}

@end
