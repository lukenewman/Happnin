//
//  PlaceObjectManager.m
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceObjectManager.h"
#import "MappingProvider.h"
#import "RKManagedObjectStore.h"

@implementation PlaceObjectManager

+ (instancetype) sharedManager {
    static dispatch_once_t onceToken;
    static id sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [super sharedManager];
    });
    
//    sharedManager.managedObjectStore = [RKManagedObjectStore defaultStore];
    
    return sharedManager;
}

- (void) setupRequestDescriptors {
    // probably won't need this
}

- (void) setupResponseDescriptors; {
    [super setupResponseDescriptors];
    
    RKResponseDescriptor *placeListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider placeMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/places"
                                                keyPath:@"businesses"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];

    [self addResponseDescriptor:placeListResponseDescriptor];
}

@end
