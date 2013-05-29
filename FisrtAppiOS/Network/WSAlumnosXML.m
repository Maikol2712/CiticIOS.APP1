//
//  WSAlumnosXML.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 23/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//

#import "WSAlumnosXML.h"

@implementation WSAlumnosXML

- (void)getAlumnos:(id)aController {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    // Asignamos para el protocolo informal
    controller = aController;
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:3000/stundents.xml"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

// Gestiona si la conexión es correcta
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
        
        int status = [httpRes statusCode];
        
        if ((status >= 200) && (status < 301)) {
            wipData = [[NSMutableData alloc] init];
        } else {
#ifndef NDEBUG
            NSLog(@"[%@] %@ Error: %i", NSStringFromClass([self class]), NSStringFromSelector(_cmd), status);
#endif
        }
    }
}

// Recibir la información
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [wipData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    [self parseDocument:wipData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    
    if ([controller respondsToSelector:@selector(updateView:)]) {
        [controller performSelector:@selector(updateView:) withObject:resultSet];
    }
    
}

#pragma mark - parsing xml
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"stundents"]) {
        resultSet = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"stundent"]) {
        tmpAlumno = [[Alumno alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
#ifndef NDEBUG
    NSLog(@"[%@] %@ EN:%@ CONT:%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), elementName, _contentsOfElement);
#endif
    
    if ([elementName isEqualToString:@"name"]) {
        [tmpAlumno setName:_contentsOfElement];
    } else if ([elementName isEqualToString:@"lastname"]) {
        [tmpAlumno setLastname:_contentsOfElement];
    } else if ([elementName isEqualToString:@"city"]) {
        [tmpAlumno setCity:_contentsOfElement];
    } else if ([elementName isEqualToString:@"email"]) {
        [tmpAlumno setEmail:_contentsOfElement];
    }
    
    if ([elementName isEqualToString:@"stundent"]) {
        [resultSet addObject:tmpAlumno];
    }
    
    [self clearContentsOfElement];
}
@end
