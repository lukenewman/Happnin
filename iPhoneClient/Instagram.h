//
//  Instagram.h
//  Happnin
//
//  Created by Luke Newman on 3/23/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Instagram : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * mediaType;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * profileImageURL;
@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;

@end
