//
//  GeoJSON.m
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import "GeoJSON.h"

@implementation GeoJSON

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.type = dictionary[@"type"];
        self.metadata = dictionary[@"metadata"];
        self.features = dictionary[@"features"];
        self.bbox = dictionary[@"bbox"];
    }
    return self;
}

@end
