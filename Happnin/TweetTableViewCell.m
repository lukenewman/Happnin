//
//  TweetTableViewCell.m
//  Happnin
//
//  Created by Luke Newman on 4/8/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// (1)
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // (2)
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    
    // (3)
    self.tweetTextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.tweetTextLabel.frame);
}

@end
