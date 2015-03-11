//
//  Place.h
//  iPhoneClient
//
//  Created by Luke Newman on 3/10/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * thumbnail_url;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * is_closed;
@property (nonatomic, retain) NSSet *media;
@property (nonatomic, retain) NSManagedObject *place_list;

@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addMediaObject:(NSManagedObject *)value;
- (void)removeMediaObject:(NSManagedObject *)value;
- (void)addMedia:(NSSet *)values;
- (void)removeMedia:(NSSet *)values;

@end
