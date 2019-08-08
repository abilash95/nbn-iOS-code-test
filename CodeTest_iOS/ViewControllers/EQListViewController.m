//
//  EQListViewController.m
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import "EQListViewController.h"
#import "AFHTTPSessionManager.h"
#import "EQTableViewCell.h"
#import "GeoJSON.h"
#import "EQMapViewController.h"

#define EQ_URL @"https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

#define EQMapViewSegueIdentifier @"EQMapViewControllerSegue"
#define EQDateFormat @"dd/MM/yyy hh:mm a"
#define EQPROPERTIES @"properties"
#define EQPLACE @"place"
#define EQTYPE @"type"
#define EQTIME @"time"
#define EQMAGNITUDE @"mag"

@interface EQListViewController ()

@property NSDateFormatter *dateformatter;

@end

@implementation EQListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
}

- (void) fetchData {
    [self fetchDataFromServerForURL:EQ_URL
                          onSuccess:^(GeoJSON *geoJSON) {
                              self.eqFeaturesList = [[NSArray alloc]initWithArray:geoJSON.features];
                              [self.tableView reloadData];
                          } onFailure:^(NSError *error) {
                              [self showErrorAlert];
                          }];
}

/**
 Fetch earthquake details from the server.
 @param success A block object to be executed when the task finishes successfully. This block returns a GeoJSON object on success.
 @param failure A block object to be executed when the task finishes unsuccessfully. This block returns an error of NSError type.
 **/
- (void)fetchDataFromServerForURL: (NSString *) url onSuccess: (void (^)(GeoJSON *geoJSON))success onFailure: (void (^)(NSError* error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GeoJSON *geoJSON = [[GeoJSON alloc] initWithDictionary:responseObject];
        success(geoJSON);
        [manager invalidateSessionCancelingTasks:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [manager invalidateSessionCancelingTasks:YES];
    }];
}

/**
 Shows an error alert when the API fails.
 **/
- (void) showErrorAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Couldn't load the data !!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self fetchData];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eqFeaturesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EQTableViewCell" forIndexPath:indexPath];
    
    double time = [[[[self.eqFeaturesList objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQTIME] doubleValue];
    double magnitude = [[[[self.eqFeaturesList objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQMAGNITUDE] doubleValue];
    
    cell.placeLabel.text = [[[self.eqFeaturesList objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQPLACE];
    cell.typeLabel.text = [[[self.eqFeaturesList objectAtIndex:indexPath.row] valueForKey:EQPROPERTIES] valueForKey:EQTYPE];
    cell.timeLabel.text =  [self getDateTime:time];
    cell.magnitudeLabel.text = [NSString stringWithFormat:@"%.02f", magnitude];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:EQMapViewSegueIdentifier])
    {
        EQMapViewController *mapViewController = (EQMapViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) sender];
        mapViewController.selectedFeature = self.eqFeaturesList[indexPath.row];
    }
}

#pragma mark - Utility
/**
 Converts the timestamp from API response to respective human readable date time string
 @param timeStamp A long integer received in the API response.
 @return Date time of NSString type
 **/
- (NSString *)getDateTime: (double)timeStamp {
    NSTimeInterval timeInterval=timeStamp/1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    if (self.dateformatter == nil) {
        self.dateformatter = [[NSDateFormatter alloc]init];
        [self.dateformatter setDateFormat:EQDateFormat];
    }
    NSString *dateString=[self.dateformatter stringFromDate:date];
    return dateString;
}

@end
