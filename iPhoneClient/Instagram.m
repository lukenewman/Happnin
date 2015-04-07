//
//  Instagram.m
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "Instagram.h"

@implementation Instagram

- (BOOL)validateType:(id *)ioValue error:(NSError **)outError {
    NSLog(@"validating Instagram type");
    if ([(NSString *)*ioValue isEqualToString:@"Instagram"]) {
        NSLog(@"%@ is equal to Instagram", [(Instagram *)*ioValue type]);
        return YES;
    }
    return NO;
}

@end
