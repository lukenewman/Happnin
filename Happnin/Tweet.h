//
//  Tweet.h
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

@interface Tweet : Media

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * profileImageURL;

@end
