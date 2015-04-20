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
#import "Instagram.h"
#import "Tweet.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *barsButton;
@property (weak, nonatomic) IBOutlet UIButton *restaurantsButton;
@property (weak, nonatomic) IBOutlet UIButton *clubsButton;
@property (weak, nonatomic) IBOutlet UIButton *cafesButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIBarButtonItem *searchBarButton;

@property (strong, nonatomic) UIColor *mainPurpleColor;
@property CLLocation *currentLocation;

@end

@implementation MainViewController

#pragma mark - Setters

- (UIColor *)mainPurpleColor {
    if (!_mainPurpleColor) {
        _mainPurpleColor = [UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f];
    }
    return _mainPurpleColor;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"Search a different location";
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
    }
    return _searchBar;
}

- (UIBarButtonItem *)searchBarButton {
    if (!_searchBarButton) {
        _searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar)];
        NSLog(@"created search button");
    }
    return _searchBarButton;
}

#pragma mark - View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureRestKit];
    [self configureLocationManager];
    
    self.navigationItem.title = @"Happnin";
    self.navigationItem.rightBarButtonItem = self.searchBarButton;
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"CheddarJack" size:37.0], NSFontAttributeName, nil]];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlaceListTableViewController *destViewController = (PlaceListTableViewController *)[segue destinationViewController];
    
    NSString *coordinateString = [NSString stringWithFormat:@"%f,%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
    
    if ([[segue identifier] isEqualToString:@"showRestaurants"]) {
        destViewController.navigationItem.title = @"Restaurants";
        [destViewController loadVenuesWithSection:@"restaurants" andCoordinate:coordinateString];
    } else if ([[segue identifier] isEqualToString:@"showBars"]) {
        destViewController.navigationItem.title = @"Bars";
        [destViewController loadVenuesWithSection:@"bars" andCoordinate:coordinateString];
    } else if ([[segue identifier] isEqualToString:@"showClubs"]) {
        destViewController.navigationItem.title = @"Clubs";
        [destViewController loadVenuesWithSection:@"danceclubs" andCoordinate:coordinateString];
    } else if ([[segue identifier] isEqualToString:@"showCafes"]) {
        destViewController.navigationItem.title = @"Cafes";
        [destViewController loadVenuesWithSection:@"cafes" andCoordinate:coordinateString];
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Back"
                                   style: UIBarButtonItemStylePlain
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
}

#pragma mark - Searching Another Location

- (void)showSearchBar {
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = self.searchBar;
}

- (void)hideSearchBar {
    self.navigationItem.rightBarButtonItem = self.searchBarButton;
    self.navigationItem.titleView = nil;
}

// user tapped 'cancel' next to search bar
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self hideSearchBar];
}

// user tapped 'search' on keyboard
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text != nil) {
        self.locationLabel.text = [NSString stringWithFormat:@"in %@", searchBar.text];
    }
    // TODO change the current location to whatever was searched
    [searchBar resignFirstResponder];
    [self hideSearchBar];
}

#pragma mark - Location Manager

- (void)configureLocationManager {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.currentLocation = newLocation;
    NSLog(@"Location: %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

#pragma mark - RestKit

- (void)configureRestKit {
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://happnin.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient: httpClient];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *placeListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider placeMapping]
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/places"
                                                keyPath:@"businesses"
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     ];
    
    RKDynamicMapping *dynamicMapping = [RKDynamicMapping new];
    RKObjectMapping *instagramMapping = [MappingProvider instagramMapping];
    RKObjectMapping *tweetMapping = [MappingProvider tweetMapping];
    [dynamicMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"mediaType" expectedValue:@"Instagram" objectMapping:instagramMapping]];
    [dynamicMapping addMatcher:[RKObjectMappingMatcher matcherWithKeyPath:@"mediaType" expectedValue:@"Twitter" objectMapping:tweetMapping]];
    
    [objectManager addResponseDescriptor:placeListResponseDescriptor];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:dynamicMapping
                                                                                      method:RKRequestMethodGET
                                                                                 pathPattern:@"/medias"
                                                                                     keyPath:@"data"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    // enable the activity indicator in the top bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
