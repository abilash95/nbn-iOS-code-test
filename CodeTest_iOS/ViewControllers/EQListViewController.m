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

#define EQ_URL @"https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

@interface EQListViewController ()

@end

@implementation EQListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
}

- (void) fetchData {
    [self fetchDataFromServer:^(GeoJSON *geoJSON) {
        self.eqFeaturesList = [[NSArray alloc]initWithArray:geoJSON.features];
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        // TODO: show alert
    }];
}

- (void)fetchDataFromServer: (void (^)(GeoJSON *geoJSON))success onFailure: (void (^)(NSError* error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:EQ_URL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GeoJSON *geoJSON = [[GeoJSON alloc] initWithDictionary:responseObject];
        success(geoJSON);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eqFeaturesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EQTableViewCell" forIndexPath:indexPath];
    
    // Sample placeholder info
    cell.placeLabel.text = @"4km NNE of Redoubt Volcano, Alaska";
    cell.typeLabel.text = @"earthquake";
    cell.timeLabel.text = @"dd/MM/yyy hh:mm a";
    cell.magnitudeLabel.text = @".05";
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
