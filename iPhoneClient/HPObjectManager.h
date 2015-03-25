//
//  HPObjectManager.h
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "RKObjectManager.h"

@interface HPObjectManager : RKObjectManager

+ (instancetype) sharedManager;

- (void) setupRequestDescriptors;

- (void) setupResponseDescriptors;

@end
