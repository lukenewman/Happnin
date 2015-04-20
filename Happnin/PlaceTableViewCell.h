//
//  PlaceTableViewCell.h
//  Happnin
//
//  Created by Luke Newman on 4/12/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *placeImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@end
