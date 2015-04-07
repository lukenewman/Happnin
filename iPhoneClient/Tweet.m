//
//  Tweet.m
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (BOOL)validateType:(id *)ioValue error:(NSError **)outError {
    NSLog(@"validating Tweet type");
    if ([(NSString *)*ioValue isEqualToString:@"Tweet"]) {
        NSLog(@"%@ is equal to Tweet", [(Tweet *)*ioValue type]);
        return YES;
    }
    return NO;
}

@end
