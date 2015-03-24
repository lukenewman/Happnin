//
//  Tweet.h
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Media.h"


@interface Tweet : Media

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * profileImageURL;

@end
