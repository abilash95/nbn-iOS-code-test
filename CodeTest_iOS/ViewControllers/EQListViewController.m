//
//  EQListViewController.m
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import "EQListViewController.h"
#import "EQTableViewCell.h"

@interface EQListViewController ()

@end

@implementation EQListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Sample placeholder info
    return 5;
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
