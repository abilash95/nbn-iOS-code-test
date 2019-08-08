//
//  EQMapViewController.m
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import "EQMapViewController.h"

#define EQPROPERTIES @"properties"
#define EQPLACE @"place"
#define EQGEOMETRY @"geometry"
#define EQCOORDINATE @"coordinates"

@interface EQMapViewController ()

@end

@implementation EQMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLocationOnMap];
}

/**
 Shows the selected location on the map.
 **/
- (void)showLocationOnMap {
    NSString* place = [[self.selectedFeature valueForKey:EQPROPERTIES] valueForKey:EQPLACE];
    NSArray* coordiante = [[self.selectedFeature valueForKey:EQGEOMETRY] valueForKey:EQCOORDINATE];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    CLLocationCoordinate2D location;
    location.latitude = [[coordiante objectAtIndex:1] doubleValue];
    location.longitude= [[coordiante objectAtIndex:0] doubleValue];
    region.span = span;
    region.center = location;
    [self.mapView setRegion:region animated:YES];
    self.mapView.showsUserLocation = YES;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = place;
    
    [self.mapView addAnnotation:point];
}

@end
