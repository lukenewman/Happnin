//
//  PlaceDetailTableViewCell.h
//  Happnin
//
//  Created by Luke Newman on 3/30/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface PlaceDetailTableViewController : UITableViewController

@property Place *place;

- (void)loadMedia;

@end
