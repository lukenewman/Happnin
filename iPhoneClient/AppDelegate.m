//
//  AppDelegate.m
//  iPhoneClient
//
//  Created by Luke Newman on 2/26/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize RestKit
    NSURL *baseURL = [NSURL URLWithString:@"http://agile-tor-1071.herokuapp.com"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Initialize managed object model from bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Initialize managed object store
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    // Complete Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingString:@"PlaceDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    // ********** Figure out why persistentStore is unused
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // ----- ATTRIBUTE MAPPING -----
    
    // '/places'
    RKEntityMapping *placeListMapping = [RKEntityMapping mappingForEntityForName:@"PlaceList" inManagedObjectStore:managedObjectStore];
    placeListMapping.identificationAttributes = @[ @"category" ];
    [placeListMapping addAttributeMappingsFromDictionary:
        @{
          @"category": @"category"
          }
     ];
    
    // '/places' - Mapping 'businesses' array elements to Place objects
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
    
    // '/medias'
    RKEntityMapping *mediaListMapping = [RKEntityMapping mappingForEntityForName:@"MediaList" inManagedObjectStore:managedObjectStore];
    mediaListMapping.identificationAttributes = @[ @"" ];
    // ********** need to figure out if we need identification attribute for mediaList
    
    // '/medias'
    RKEntityMapping *tweetMapping = [RKEntityMapping mappingForEntityForName:@"Tweet" inManagedObjectStore:managedObjectStore];
    tweetMapping.identificationAttributes = @[ @"" ];
    // ********** need to figure out if we need identification attribute for tweets
    [tweetMapping addAttributeMappingsFromDictionary:
        @{
          @"createdAt": @"createdAt",
          @"mediaType": @"mediaType",
          @"text": @"text",
          @"username": @"username",
          @"profileImageURL": @"profileImageURL"
          }
     ];
    
    // '/medias'
    RKEntityMapping *instagramMapping = [RKEntityMapping mappingForEntityForName:@"Instagram" inManagedObjectStore:managedObjectStore];
    instagramMapping.identificationAttributes = @[ @"" ];
    // ********** need to figure out if we need identification attribute for instagrams
    [instagramMapping addAttributeMappingsFromDictionary:
        @{
          @"createdAt": @"createdAt",
          @"mediaType": @"mediaType",
          @"imageURL": @"imageURL",
          @"username": @"username",
          @"profileImageURL": @"profileImageURL",
          @"caption": @"caption",
          @"type": @"type",
          @"width": @"width",
          @"height": @"height"
          }
     ];
    
    // ----- RELATIONSHIP MAPPING -----
    
    // Mapping 'businesses' array to PlaceList object relationship 'places'
    [placeListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"places"
                                                                                      toKeyPath:@"places"
                                                                                    withMapping:placeMapping]
     ];
    
    // ********** Need to map relationships between (place and mediaList) and (mediaList and tweets and instagram posts)
    
    // ----- PATH MAPPING -----
    
    // All responses to '/places' will be mapped using placeListMapping
    RKResponseDescriptor *placeListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:placeListMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/places"
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    // All response to '/medias' will be mapped using mediaListMapping
    RKResponseDescriptor *mediaListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:mediaListMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/medias/"
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // Add the response descriptors defined above to the object manager.
    [objectManager addResponseDescriptor:placeListResponseDescriptor];
    [objectManager addResponseDescriptor:mediaListResponseDescriptor];
    
    // Enable the activity indicator in the top bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return YES;
}

@end
