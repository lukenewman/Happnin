//
//  PlaceDetailTableViewCell.m
//  Happnin
//
//  Created by Luke Newman on 3/30/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceDetailTableViewController.h"
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Media.h"
#import "Instagram.h"
#import "Tweet.h"

@interface PlaceDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *directionsButton;

@property (strong, nonatomic) NSArray *medias;

@end

@implementation PlaceDetailTableViewController 

- (void)viewDidLoad {
    // put this in cell for row at index path
    [self.callButton.layer setBorderWidth:1.0f];
    [self.callButton.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f].CGColor];
    [self.callButton.layer setCornerRadius:7.0f];
    
    [self.directionsButton.layer setBorderWidth:1.0f];
    [self.directionsButton.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f].CGColor];
    [self.directionsButton.layer setCornerRadius:7.0f];
    
    CALayer *imageLayer = self.placeImage.layer;
    [imageLayer setCornerRadius:10.0f];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];
    self.placeImage.image = [UIImage imageWithData:self.place.imageData];
    
    self.nameLabel.text = self.place.name;
    
    self.navigationItem.title = self.place.name;
}

    // open up Phone with the place's number entered
- (IBAction)callPlace:(id)sender {
    NSString *phoneURL = [NSString stringWithFormat:@"tel://%@", self.place.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURL]];
}

- (IBAction)showDirections:(id)sender {
    // Create an MKMapItem to pass to the Maps app
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.place.latitude doubleValue], [self.place.longitude doubleValue]);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:self.place.name];
    
    // Pass the map item to the Maps app
    [mapItem openInMapsWithLaunchOptions:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.medias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        // setup the place detail cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceDetailCell" forIndexPath:indexPath];
    } else if ([((Media *)self.medias[indexPath.row]).type isEqualToString:@"Instagram"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"InstagramCell" forIndexPath:indexPath];
    } else if ([((Media *)self.medias[indexPath.row]).type isEqualToString:@"Tweet"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    } else {
        // some error
    }
    
    
    
    return cell;
}

#pragma mark - RestKit

- (void)loadMedia {
    NSString *locString = [NSString stringWithFormat:@"%@,%@", self.place.latitude, self.place.longitude];
    
    NSDictionary *parameters = @{
                                 @"q": @"",
                                 @"loc": locString
                                 };
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/medias"
                                           parameters:parameters
                                              success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  self.medias = mappingResult.array;
                                                  NSLog(@"self.medias: %@", self.medias);
                                              }
                                              failure: ^(RKObjectRequestOperation *operation, NSError *error) {
                                                  RKLogError(@"Load failed with error: %@", error);
                                              }
     ];
}

@end
