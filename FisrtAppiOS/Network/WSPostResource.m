//
//  WSPostResource.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 24/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//
#import "SWResource.h"
#import "AFNetworking.h"
#import "WSPostResource.h"

@implementation WSPostResource

- (void)postResource:(SWResource *)aResource forController:(id)aController {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    controller = aController;
    
    NSURL *url = [NSURL URLWithString:kLocalUrl];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:aResource.name forKey:@"resource[name]"];
    [params setObject:aResource.description forKey:@"resource[description]"];
    [params setObject:aResource.urlString forKey:@"resource[link]"];
    
    NSMutableURLRequest *request = [client
                                    multipartFormRequestWithMethod:@"POST"
                                    path:@"resources/create.json"
                                    parameters:params
                                    constructingBodyWithBlock:nil];
    
    
    AFHTTPRequestOperation *conn = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [conn setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([controller respondsToSelector:@selector(postOk)]) {
            [controller performSelector:@selector(postOk)];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([controller respondsToSelector:@selector(postKo)]) {
            [controller performSelector:@selector(postKo)];
        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:conn];
}

@end
