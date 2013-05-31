//
//  WSJsonResouces.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 24/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//
// URL : http://10.19.17.63:3000/resources.json
//
#import "SWResource.h"
#import "JSONKit.h"
#import "AFNetworking.h"
#import "WSJsonResouces.h"

@implementation WSJsonResouces

- (void)getAllResourcesWithController:(id)aController {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    controller = aController;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/resources.json", kLocalUrl]]];
    
    AFJSONRequestOperation *connection = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif

    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in JSON) {
        SWResource *tmp = [[SWResource alloc] initWithName:[dic objectForKey:@"name"]
                                               description:[dic objectForKey:@"description"] andUrlString:[dic objectForKey:@"link"]];
        [results addObject:tmp];
    }
    
    if ([results count] > 0) {
        if ([controller respondsToSelector:@selector(updateView:)]) {
            [controller performSelector:@selector(updateView:) withObject:results];
        }
    } else {
        if ([controller respondsToSelector:@selector(updateWithErrors)]) {
            [controller performSelector:@selector(updateWithErrors)];
        }
    }

} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    
    if ([controller respondsToSelector:@selector(updateWithErrors)]) {
        [controller performSelector:@selector(updateWithErrors)];
    }
    
}];
    
    [connection start];
}

@end
