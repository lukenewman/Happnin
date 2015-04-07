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
@property (strong, nonatomic) UIColor *mainPurpleColor;

@end

@implementation MainViewController

- (UIColor *)mainPurpleColor {
    if (!_mainPurpleColor) {
        _mainPurpleColor = [UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f];
    }
    return _mainPurpleColor;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureRestKit];
    
    self.navigationItem.title = @"Happnin";
    
    self.navigationController.hidesBarsOnSwipe = NO;
    self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    
    [self.barsButton.layer setBorderWidth:1.0f];
    [self.barsButton.layer setBorderColor:self.mainPurpleColor.CGColor];
    [self.barsButton.layer setCornerRadius:10.0f];
    
    [self.restaurantsButton.layer setBorderWidth:1.0f];
    [self.restaurantsButton.layer setBorderColor:self.mainPurpleColor.CGColor];
    [self.restaurantsButton.layer setCornerRadius:10.0f];
    
    [self.clubsButton.layer setBorderWidth:1.0f];
    [self.clubsButton.layer setBorderColor:self.mainPurpleColor.CGColor];
    [self.clubsButton.layer setCornerRadius:10.0f];
    
    [self.cafesButton.layer setBorderWidth:1.0f];
    [self.cafesButton.layer setBorderColor:self.mainPurpleColor.CGColor];
    [self.cafesButton.layer setCornerRadius:10.0f];
}

- (IBAction)searchLocationButtonTapped:(id)sender {
    // animate some sort of search bar across the navigation bar
    // the user will enter in a location
    // somehow handle getting the keyboard out of the way
    // when a section button is tapped, take the string out of the
    //   search bar and use that as the search location
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
    
    RKResponseDescriptor *instagramResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider instagramMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/medias"
                                                keyPath:@"data"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *tweetResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider tweetMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/medias"
                                                keyPath:@"data"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:placeListResponseDescriptor];
    [objectManager addResponseDescriptor:instagramResponseDescriptor];
    [objectManager addResponseDescriptor:tweetResponseDescriptor];
    
    // enable the activity indicator in the top bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
