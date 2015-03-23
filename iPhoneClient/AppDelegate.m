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
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // -----
    
    RKEntityMapping *placeListMapping = [RKEntityMapping mappingForEntityForName:@"PlaceList" inManagedObjectStore:managedObjectStore];
    placeListMapping.identificationAttributes = @[ @"category" ];
    
    // Need to add mappings here -- maybe just set the PlaceList category field explicitly based on the button?

    // Mapping JSON reponse data to places list
    [placeListMapping addAttributeMappingsFromDictionary:
        @{
          @"category": @"category"
          }
     ];
    
    // Mapping 'businesses' array elements to Place objects
    RKEntityMapping *placeMapping = [RKEntityMapping mappingForEntityForName:@"Place" inManagedObjectStore:managedObjectStore];
    placeMapping.identificationAttributes = @[ @"name" ];
    [placeMapping addAttributeMappingsFromDictionary:
        @{
          @"name": @"name",
          @"image_url": @"thumbnail_url",
//          @"latitude": @"location.coordinate.latitude",
//          @"longitude": @"location.coordinate.longitude",
          @"is_closed": @"is_closed"
          }
     ];
    
    // Mapping 'businesses' array to PlaceList object relationship 'places'
    [placeListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"places"
                                                                                      toKeyPath:@"places"
                                                                                    withMapping:placeMapping]
     ];
    
    // All responses to the pathPattern defined below will be mapped using placesListMapping
    RKResponseDescriptor *placeListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:placeListMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/places"
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    // Add the response descriptor defined above to the object manager.
    [objectManager addResponseDescriptor:placeListResponseDescriptor];
    
    // Enable the activity indicator in the top bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return YES;
}

@end
