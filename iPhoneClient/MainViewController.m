//
//  MainViewController.m
//  iPhoneClient
//
//  Created by Luke Newman on 3/15/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "MainViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *barsButton;
@property (weak, nonatomic) IBOutlet UIButton *restaurantsButton;
@property (weak, nonatomic) IBOutlet UIButton *clubsButton;
@property (weak, nonatomic) IBOutlet UIButton *cafesButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.barsButton.layer setBorderWidth:1.0f];
    [self.barsButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.barsButton.layer setCornerRadius:10.0f];
    //self.barsButton.frame = CGRectMake(self.barsButton.layer., <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    [self.restaurantsButton.layer setBorderWidth:1.0f];
    [self.restaurantsButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.restaurantsButton.layer setCornerRadius:10.0f];
    
    [self.clubsButton.layer setBorderWidth:1.0f];
    [self.clubsButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.clubsButton.layer setCornerRadius:10.0f];
    
    [self.cafesButton.layer setBorderWidth:1.0f];
    [self.cafesButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.cafesButton.layer setCornerRadius:10.0f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
