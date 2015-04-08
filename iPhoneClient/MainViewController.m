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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButtonOutlet;

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIBarButtonItem *searchItem;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (strong, nonatomic) UIColor *mainPurpleColor;
@property CLLocation *currentLocation;

@end

@implementation MainViewController

- (UIColor *)mainPurpleColor {
    if (!_mainPurpleColor) {
        _mainPurpleColor = [UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f];
    }
    return _mainPurpleColor;
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureRestKit];
    
    [self configureLocationManager];
    
    [self configureSearch];
    
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

//- (IBAction)searchLocationButtonTapped:(id)sender {
//    // animate some sort of search bar across the navigation bar
//    // the user will enter in a location
//    // somehow handle getting the keyboard out of the way
//    // when a section button is tapped, take the string out of the
//    //   search bar and use that as the search location
//    
//    // use the search bar content as geocodeAddressString
//    // the following code would be run when the button is tapped
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder geocodeAddressString:@"6138 Bollinger Road, San Jose, United States" completionHandler:^(NSArray* placemarks, NSError* error){
//        for (CLPlacemark* aPlacemark in placemarks)
//        {
//            // Process the placemark.
//            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
//            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
//            NSLog(@"lat: %@, lng: %@", latDest1, lngDest1);
//        }
//    }];
//}

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Back"
                                   style: UIBarButtonItemStylePlain
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
}

#pragma mark - Search Functionality

- (void)configureSearch {
    // create the magnifying glass button
    self.searchButton = [[UIButton alloc] init];
    // add button images, etc.
    [_searchButton addTarget:self action:@selector(searchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

//    self.searchButtonOutlet.target = self;
//    self.searchButtonOutlet.action = @selector(searchButtonTapped:);
    
    self.searchItem = [[UIBarButtonItem alloc] initWithCustomView:_searchButton];
    self.navigationItem.rightBarButtonItem = _searchItem;

    self.searchBar = [[UISearchBar alloc] init];
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
}

- (void)searchButtonTapped:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        _searchButton.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        // remove the search button
        self.navigationItem.rightBarButtonItem = nil;
        // add the search bar (which will start out hidden).
        self.navigationItem.titleView = _searchBar;
        _searchBar.alpha = 0.0;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _searchBar.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             [_searchBar becomeFirstResponder];
                         }];
        
    }];
}

// UISearchBar delegate method
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.5f animations:^{
        _searchBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = _searchItem;
        _searchButton.alpha = 0.0;  // set this *after* adding it back
        [UIView animateWithDuration:0.5f animations:^ {
            _searchButton.alpha = 1.0;
        }];
    }];
    
}// called when cancel button pressed

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
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
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
    
//    RKResponseDescriptor *tweetResponseDescriptor =
//    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider tweetMapping]
//                                                 method:RKRequestMethodGET
//                                            pathPattern:@"/medias"
//                                                keyPath:@"data"
//                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    
//    RKResponseDescriptor *instagramResponseDescriptor =
//    [RKResponseDescriptor responseDescriptorWithMapping:[MappingProvider instagramMapping]
//                                                 method:RKRequestMethodGET
//                                            pathPattern:@"/medias"
//                                                keyPath:@"data"
//                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
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
    //    [objectManager addResponseDescriptor:instagramResponseDescriptor];
    //    [objectManager addResponseDescriptor:tweetResponseDescriptor];
    
    // enable the activity indicator in the top bar
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

@end
