//
//  PlaceObjectManager.m
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceObjectManager.h"

@implementation PlaceObjectManager

+ (instancetype) sharedManager {
    static dispatch_once_t onceToken;
    static id sharedManager;
    dispatch_once(&onceToken, ^{
        sharedManager = [super sharedManager];
    });
    
    return sharedManager;
}

- (void) setupRequestDescriptors {
    // probably won't need this
}

- (void) setupResponseDescriptors; {
    // put response descriptors here
    //    [objectManager addResponseDescriptor:placeListResponseDescriptor];
}

@end
