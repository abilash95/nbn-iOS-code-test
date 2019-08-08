//
//  EQMapViewController.h
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EQMapViewController : UIViewController 

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic)  NSDictionary *selectedFeature;

- (void)showLocationOnMap;

@end

NS_ASSUME_NONNULL_END
