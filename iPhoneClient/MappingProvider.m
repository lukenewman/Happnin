//
//  MappingProvider.m
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "MappingProvider.h"
#import <RestKit/RestKit.h>

@implementation MappingProvider

+ (RKObjectMapping *) placeMapping {
    RKEntityMapping *placeMapping = [RKEntityMapping mappingForEntityForName:@"Place" inManagedObjectStore:managedObjectStore];
    placeMapping.identificationAttributes = @[ @"name" ];
    [placeMapping addAttributeMappingsFromDictionary:
     @{
       @"id": @"id",
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

+ (RKObjectMapping *) placeListMapping {
    RKEntityMapping *placeListMapping = [RKEntityMapping mappingForEntityForName:@"PlaceList" inManagedObjectStore:managedObjectStore];
    placeListMapping.identificationAttributes = @[ @"category" ];
    [placeListMapping addAttributeMappingsFromDictionary:
     @{
       @"category": @"category"
       }
     ];
    
    return placeListMapping;
}

+ (RKObjectMapping *) mediaMapping {
    //    RKEntityMapping *tweetMapping = [RKEntityMapping mappingForEntityForName:@"Tweet" inManagedObjectStore:managedObjectStore];
    //tweetMapping.identificationAttributes = @[ @"" ];
    // ********** need to figure out if we need identification attribute for tweets
    //    [tweetMapping addAttributeMappingsFromArray: @[ @"createdAt", @"text", @"username", @"profileImageURL"]];
    
    // '/medias'
    //    RKEntityMapping *instagramMapping = [RKEntityMapping mappingForEntityForName:@"Instagram" inManagedObjectStore:managedObjectStore];
    //instagramMapping.identificationAttributes = @[ @"" ];
    // ********** need to figure out if we need identification attribute for instagrams
    //    [instagramMapping addAttributeMappingsFromArray: @[ @"createdAt", @"imageURL", @"username", @"profileImageURL", @"caption", @"type", @"width", @"height" ]];
    
    // ----- RELATIONSHIP MAPPING -----
    
    // Mapping 'businesses' array to PlaceList object relationship 'places'
    //    [placeListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"places"
    //                                                                                      toKeyPath:@"places"
    //                                                                                    withMapping:placeMapping]
    //     ];
}

+ (RKObjectMapping *) mediaListMapping {
    
}

@end
