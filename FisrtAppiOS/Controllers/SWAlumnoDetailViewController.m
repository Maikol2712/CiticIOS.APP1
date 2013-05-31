//
//  SWAlumnoDetailViewController.m
//  FisrtAppiOS
//
//  Created by Pablo Formoso Estada on 30/05/13.
//  Copyright (c) 2013 Softwhipser. All rights reserved.
//
#import "Alumno.h"
#import "UIImageView+AFNetworking.h"
#import "SWAlumnoDetailViewController.h"
#import "CiticAnnotation.h"
#import "BasicAnnotation.h"

@interface SWAlumnoDetailViewController () {
    CLLocation *lastcoordinate;
    SWLocationManager *locationManger;
}

@end

@implementation SWAlumnoDetailViewController

- (void)viewDidLoad {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    [super viewDidLoad];
    
    locationManger = [[SWLocationManager alloc] init];
    locationManger.delegate = self;
    [locationManger.locationManager startUpdatingLocation];
    
    _nameLabel.text = _alumno.name;
    _emailLabel.text = _alumno.email;
    [_avatarImageView setImageWithURL:_alumno.avatarUrl];

    CiticAnnotation *annot = [[CiticAnnotation alloc] init];
    [_mapView addAnnotation:annot];
    
    BasicAnnotation *b1 = [[BasicAnnotation alloc] initWithTitle:@"pin1"
                                                        subtitle:@"sub pin1"
                                                  andCoordinates:CLLocationCoordinate2DMake(43.3222746, -8.403070)];
    
    BasicAnnotation *b2 = [[BasicAnnotation alloc] initWithTitle:@"pin2"
                                                        subtitle:@"sub pin2"
                                                  andCoordinates:CLLocationCoordinate2DMake(43.3213746, -8.411070)];
    
    BasicAnnotation *b3 = [[BasicAnnotation alloc] initWithTitle:@"pin3"
                                                        subtitle:@"sub pin3"
                                                  andCoordinates:CLLocationCoordinate2DMake(43.3212546, -8.414570)];
    
    [_mapView addAnnotations:[NSArray arrayWithObjects:b1,b2,b3,nil]];
}

- (void)didReceiveMemoryWarning {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    [super didReceiveMemoryWarning];
}

- (void)locationUpdate:(CLLocation *)location {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
    lastcoordinate = location;
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.050;
    span.longitudeDelta = 0.050;
    
    region.span = span;
    region.center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    [_mapView setRegion:region animated:YES];
}


- (void)locationError:(NSError *)error {
#ifndef NDEBUG
    NSLog(@"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#endif
    
}



@end
