//
//  AppDelegate.m
//  iPhoneClient
//
//  Created by Luke Newman on 2/26/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "AppDelegate.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark RESTKit Initialization

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     
     Need to figure out how to map the 'data' array into Media objects as either Twitter or Instagram objects based on the 'mediaType' JSON field
     
     */
    
    
    // '/medias'
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
    
    // ********** Need to map relationships between (place and mediaList) and (mediaList and tweets and instagram posts)
    
    // ----- PATH MAPPING -----
    
    // All response to '/medias' will be mapped using mediaListMapping
//    RKResponseDescriptor *mediaListResponseDescriptor =
//    [RKResponseDescriptor responseDescriptorWithMapping:mediaListMapping
//                                                 method:RKRequestMethodGET
//                                            pathPattern:nil
//                                                keyPath:@"data"
//                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Add the response descriptors defined above to the object manager.
//    [objectManager addResponseDescriptor:placeListResponseDescriptor];
//    [objectManager addResponseDescriptor:mediaListResponseDescriptor];
    
    // Enable the activity indicator in the top bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return YES;
}

@end
