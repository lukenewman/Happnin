//
//  Tweet.h
//  Happnin
//
//  Created by Luke Newman on 3/23/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * profileImageURL;
@property (nonatomic, retain) NSString * mediaType;

@end
