//
//  Media.h
//  iPhoneClient
//
//  Created by Luke Newman on 3/10/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Media : NSManagedObject

@property (nonatomic, retain) Place *owner;

@end
