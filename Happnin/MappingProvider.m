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
       @"address": @"addressArray",
       @"featuredValue": @"featuredValue"
       }
     ];
    
    return placeMapping;
}

+ (RKObjectMapping *) tweetMapping {
    RKObjectMapping *tweetMapping = [RKObjectMapping mappingForClass:[Tweet class]];
    [tweetMapping addAttributeMappingsFromDictionary:
     @{
       @"mediaType": @"type",
       @"createdAt": @"createdAt",
       @"text": @"text",
       @"username": @"username",
       @"profileImageURL": @"profileImageURL"
       }
     ];
    
    return tweetMapping;
}

+ (RKObjectMapping *) instagramMapping {
    RKObjectMapping *instagramMapping = [RKObjectMapping mappingForClass:[Instagram class]];
    [instagramMapping addAttributeMappingsFromDictionary:
     @{
       @"mediaType": @"type",
       @"createdAt": @"createdAt",
       @"imageURL": @"imageURL",
       @"username": @"username",
       @"profileImageURL": @"profileImageURL",
       @"caption": @"caption",
       @"width": @"width",
       @"height": @"height"
       }
     ];
    
    return instagramMapping;
}

@end
