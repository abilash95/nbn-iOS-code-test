//
//  GeoJSON.h
//  CodeTest_iOS
//
//  Created by Abilash Francis on 08/08/2019.
//  Copyright © 2019 Abilash Francis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeoJSON : NSObject

@property (weak, nonatomic)  NSString *type;
@property (weak, nonatomic)  NSDictionary *metadata;
@property (weak, nonatomic)  NSArray *features;
@property (weak, nonatomic)  NSArray *bbox;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
