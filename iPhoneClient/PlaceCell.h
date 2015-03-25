//
//  PlaceCellTableViewCell.h
//  Happnin
//
//  Created by Luke Newman on 3/25/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *placeImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end
