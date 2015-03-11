//
//  PlaceList.h
//  iPhoneClient
//
//  Created by Luke Newman on 3/10/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface PlaceList : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSSet *places;

@end

@interface PlaceList (CoreDataGeneratedAccessors)

- (void)addPlacesObject:(Place *)value;
- (void)removePlacesObject:(Place *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

@end
