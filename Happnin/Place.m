//
//  Place.m
//  Happnin
//
//  Created by Luke Newman on 3/24/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "Place.h"

@implementation Place

// TODO: maybe have a property with the JPG version of the image

- (BOOL)validateAddressArray:(id *)ioValue error:(NSError **)outError {
    // change the address from array to string
    NSArray *addressArray = *ioValue;
    NSMutableString *address = [[NSMutableString alloc] init];
    for (int i = 0; i < addressArray.count; i++) {
        if (i == 0) {
            [address appendString:addressArray[i]];
        } else {
            [address appendFormat:@", %@", addressArray[i]];
        }
    }
    self.address = address;
    return YES;
}

@end
