//
//  CodeTest_iOSUITests.m
//  CodeTest_iOSUITests
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EQListViewController.h"
#import "EQTableViewCell.h"

@interface CodeTest_iOSUITests : XCTestCase

@property XCUIApplication *app;
//@property (nonatomic, strong) EQListViewController *vc;

@end

@implementation CodeTest_iOSUITests

- (void)setUp {
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];


    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.app = nil;
}

- (void)testEQTableView {
    XCTAssertNotNil([self.app.tables element]);
}

- (void)testEQTableHasEQCell {
    XCUIElementQuery *tablesQuery = self.app.tables;
    XCUIElementQuery *cellQuery = [tablesQuery.cells containingType:XCUIElementTypeStaticText
                                                         identifier:@"earthquake"];
    XCTAssertNotNil(cellQuery);
}

- (void)testErrorAlertisShownWhenAPIFails {
    XCTAssertNotNil([[[self.app.otherElements containingType:XCUIElementTypeAlert identifier:@"Error"] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:0] );
}

@end

