//
//  MappingProvider.m
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "MappingProvider.h"
#import <RestKit/RestKit.h>

#import "Place.h"
#import "Media.h"
#import "Tweet.h"
#import "Instagram.h"

@implementation MappingProvider

+ (RKObjectMapping *) placeMapping {
    RKObjectMapping *placeMapping = [RKObjectMapping mappingForClass:[Place class]];
    [placeMapping addAttributeMappingsFromDictionary:
     @{
       @"id": @"ID",
       @"name": @"name",
       @"latitude": @"latitude",
       @"longitude": @"longitude",
       @"phoneNumber": @"phoneNumber",
       @"imageURL": @"imageURL",
       @"isClosed": @"isClosed",
       @"distance": @"distance",
       @"rating": @"rating",
       @"address": @"address",
       @"featuredValue": @"featuredValue"
       }
     ];
    
    return placeMapping;
}

+ (RKObjectMapping *) mediaMapping {
    RKObjectMapping *instagramMapping = [RKObjectMapping mappingForClass:[Instagram class]];
    [instagramMapping addAttributeMappingsFromDictionary: @{ @"mediaType": @"type" }];
    
    return nil;
}

+ (RKObjectMapping *) tweetMapping {
    RKObjectMapping *tweetMapping = [RKObjectMapping mappingForClass:[Tweet class]];
    [tweetMapping addAttributeMappingsFromArray: @[ @"createdAt", @"text", @"username", @"profileImageURL"]];
    
    return tweetMapping;
}

+ (RKObjectMapping *) instagramMapping {
    RKObjectMapping *instagramMapping = [RKObjectMapping mappingForClass:[Instagram class]];
    [instagramMapping addAttributeMappingsFromArray: @[ @"createdAt", @"imageURL", @"username", @"profileImageURL", @"caption", @"type", @"width", @"height" ]];
    
    return instagramMapping;
}

@end
