//
//  MainViewController.m
//  iPhoneClient
//
//  Created by Luke Newman on 3/15/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>

#import "PlaceListTableViewController.h"
#import "MappingProvider.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *barsButton;
@property (weak, nonatomic) IBOutlet UIButton *restaurantsButton;
@property (weak, nonatomic) IBOutlet UIButton *clubsButton;
@property (weak, nonatomic) IBOutlet UIButton *cafesButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureRestKit];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:103 green:58 blue:183 alpha:0.5];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName:[UIColor whiteColor] };
    
    [self.barsButton.layer setBorderWidth:1.0f];
    [self.barsButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.barsButton.layer setCornerRadius:10.0f];
    
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

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlaceListTableViewController *destViewController = (PlaceListTableViewController *)[segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"showRestaurants"]) {
        destViewController.navigationItem.title = @"Restaurants";
        [destViewController loadVenuesWithSection:@"restaurants"];
    } else if ([[segue identifier] isEqualToString:@"showBars"]) {
        destViewController.navigationItem.title = @"Bars";
        [destViewController loadVenuesWithSection:@"bars"];
    } else if ([[segue identifier] isEqualToString:@"showClubs"]) {
        destViewController.navigationItem.title = @"Clubs";
        [destViewController loadVenuesWithSection:@"danceclubs"];
    } else if ([[segue identifier] isEqualToString:@"showCafes"]) {
        destViewController.navigationItem.title = @"Cafes";
        [destViewController loadVenuesWithSection:@"cafes"];
    }
}

#pragma mark - RestKit

- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://agile-tor-1071.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient: httpClient];
    
    // setup object mappings
    // MappingProvider does this right now
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *placeListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider placeMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/places"
                                                keyPath:@"businesses"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    [objectManager addResponseDescriptor:placeListResponseDescriptor];
}

@end
