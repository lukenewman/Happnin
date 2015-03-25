//
//  MappingProvider.h
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface MappingProvider : NSObject

+ (RKObjectMapping *) placeMapping;
//+ (RKObjectMapping *) placeListMapping;
+ (RKObjectMapping *) mediaMapping;
+ (RKObjectMapping *) mediaListMapping;

@end
