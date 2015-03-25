//
//  Place.h
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Media;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSNumber * isClosed;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * identification;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phoneNumber;

@end
