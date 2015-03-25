//
//  Place.h
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (nonatomic, strong) NSNumber * isClosed;
@property (nonatomic, strong) NSNumber * latitude;
@property (nonatomic, strong) NSNumber * longitude;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imageURL;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * phoneNumber;
@property (nonatomic, strong) NSNumber * rating;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSNumber * distance;
@property (nonatomic, strong) NSNumber * featuredValue;

@end
