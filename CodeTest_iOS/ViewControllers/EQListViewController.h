//
//  EQListViewController.h
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EQListViewController : UITableViewController

@property (strong, nonatomic) NSArray* eqFeaturesList;

- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
