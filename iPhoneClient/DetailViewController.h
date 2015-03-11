//
//  DetailViewController.h
//  iPhoneClient
//
//  Created by Luke Newman on 2/26/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

