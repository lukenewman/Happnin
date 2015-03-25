//
//  Instagram.h
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

@interface Instagram : Media

@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSString * imageURL;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * profileImageURL;
@property (nonatomic, strong) NSString * caption;
@property (nonatomic, strong) NSNumber * width;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSString * typeOfMedia;

@end
