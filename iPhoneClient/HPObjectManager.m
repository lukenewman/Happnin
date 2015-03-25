//
//  HPObjectManager.m
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "HPObjectManager.h"
#import <RestKit/RestKit.h>

@interface HPObjectManager ()

- (void) setupRequestDescriptors;
- (void) setupResponseDescriptors;

@end

@implementation HPObjectManager

+ (instancetype) sharedManager {
    NSURL *url = [NSURL URLWithString:@"http://agile-tor-1071.herokuapp.com"];
    
    HPObjectManager *sharedManager = [self managerWithBaseURL:url];
    sharedManager.requestSerializationMIMEType = RKMIMETypeJSON;
    sharedManager.managedObjectStore = managedObjectStore;
    
    /*
     THIS CLASS IS MAIN POINT OF CUSTOMIZATION
     - setup HTTP headers that should exist on all HTTP requests
     - override methods in this class to change default behavior for all HTTP requests
     - define methods that should be available across all object managers
     */
    
    [sharedManager setupRequestDescriptors];
    [sharedManager setupResponseDescriptors];
    
    return sharedManager;
}

- (void) setupRequestDescriptors {
    // probably won't need this
}

- (void) setupResponseDescriptors; {
    // put response descriptors here
}

@end
