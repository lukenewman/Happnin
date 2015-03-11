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
    NSURL *baseURL = [NSURL URLWithString:@"localhost:5000"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Initialize managed object model from bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Initialize managed object store
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    // Complete Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingString:@"PlacesDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // -----
    
    RKEntityMapping *placesListMapping = [RKEntityMapping mappingForEntityForName:@"PlacesList" inManagedObjectStore:managedObjectStore];
    placesListMapping.identificationAttributes = @[ @"category" ];
    
    // Need to add mappings here -- maybe just set the PlacesList category field explicitly based on the button?

//    [placesListMapping addAttributeMappingsFromDictionary:
//        @{
//          @"json_field": @"core_data_field"
//          }];
    
    RKEntityMapping *placeMapping = [RKEntityMapping mappingForEntityForName:@"Place" inManagedObjectStore:managedObjectStore];
    placeMapping.identificationAttributes = @[ @"name" ];
    [placeMapping addAttributeMappingsFromDictionary:
        @{
          @"name": @"name",
          @"image_url": @"thumbnail_url",
          @"latitude": @"location.coordinate.latitude",
          @"longitude": @"location.coordinate.longitude",
          @"is_closed": @"is_closed"
          }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
