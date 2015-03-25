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

#pragma mark Core Data Properties

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectStore = _managedObjectStore;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lukenewman.Core_Data" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Happnin" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Happnin"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark RESTKit Initialization

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize RestKit
//    NSURL *baseURL = [NSURL URLWithString:@"http://agile-tor-1071.herokuapp.com"];
//    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Initialize managed object model from bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Initialize managed object store
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    // Complete Core Data stack initialization
//    [managedObjectStore createPersistentStoreCoordinator];
//    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingString:@"Happnin.sqlite"];
//    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
//    NSError *error;
//    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
//    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    // ********** Figure out why persistentStore is unused
    
    // Create the managed object contexts
//    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
//    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // ----- ATTRIBUTE MAPPING -----
    
    // '/medias'
//    RKEntityMapping *mediaListMapping = [RKEntityMapping mappingForEntityForName:@"MediaList" inManagedObjectStore:managedObjectStore];
    //mediaListMapping.identificationAttributes = @[ @"" ];
    // ********** need to figure out if we need identification attribute for mediaList
    
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
    
    // All responses to '/places' will be mapped using placeListMapping
//    RKResponseDescriptor *placeListResponseDescriptor =
//    [RKResponseDescriptor responseDescriptorWithMapping:placeListMapping
//                                                 method:RKRequestMethodGET
//                                            pathPattern:@"/places"
//                                                keyPath:nil
//                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
//     ];
    
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
