//
//  CodeTest_iOSTests.m
//  CodeTest_iOSTests
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EQListViewController.h"
#import "EQMapViewController.h"

@interface CodeTest_iOSTests : XCTestCase

@property EQListViewController *eqListVCToTest;
@property EQMapViewController *eqMapVCToTest;

@end

@implementation CodeTest_iOSTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.eqListVCToTest = [[EQListViewController alloc]init];
    self.eqMapVCToTest = [[EQMapViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.eqListVCToTest = nil;
    [super tearDown];
}

- (void)testFetchData{
    [self.eqListVCToTest fetchData];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch data from server"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertNotNil(self.eqListVCToTest.eqFeaturesList, "No data was downloaded.");
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
}

- (void)testErrorAlert{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch data from server fails"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertNil(self.eqListVCToTest.eqFeaturesList, "No data was downloaded.");
        [self.eqListVCToTest showErrorAlert];
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
}

- (void)testGetTime{
    NSString *time = [self.eqListVCToTest getDateTime:1557208491360];
    XCTAssert(time != nil && ![time isEqualToString:@""], @"Data source has populated time");
}

- (void)testShowSelectedLocation{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Selected location loaded as anotation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.eqListVCToTest.tableView selectRowAtIndexPath:firstRow animated:false scrollPosition:UITableViewScrollPositionNone];
        XCTAssertNil(self.eqMapVCToTest.mapView, @"Map with specefic loaction notation couldn't be loaded.");
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:20.0 handler:nil];

}

@end
