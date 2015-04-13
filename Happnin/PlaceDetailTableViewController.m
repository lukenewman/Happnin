//
//  PlaceDetailTableViewCell.m
//  Happnin
//
//  Created by Luke Newman on 3/30/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceDetailTableViewController.h"
#import <RestKit/RestKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Media.h"
#import "Instagram.h"
#import "Tweet.h"
#import "Place.h"
#import "PlaceDetailTableViewCell.h"
#import "InstagramTableViewCell.h"
#import "TweetTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlaceDetailTableViewController ()

@property (strong, nonatomic) NSArray *medias;

@end

@implementation PlaceDetailTableViewController

static NSString *PlaceDetailCellIdentifier = @"PlaceDetailCell";
static NSString *InstagramCellIdentifier = @"InstagramCell";
static NSString *TweetCellIdentifier = @"TweetCell";

- (void)viewDidLoad {
    self.navigationController.hidesBarsOnSwipe = YES;
    self.navigationItem.title = self.place.name;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceDetailCell" bundle:nil] forCellReuseIdentifier:PlaceDetailCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"InstagramCell" bundle:nil] forCellReuseIdentifier:InstagramCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:TweetCellIdentifier];
}

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.medias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PlaceDetailTableViewCell *cell = (PlaceDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PlaceDetailCellIdentifier forIndexPath:indexPath];
        
        cell.nameLabel.text = self.place.name;
        
        CALayer *imageLayer = cell.placeImageView.layer;
        [imageLayer setCornerRadius:10.0f];
        [imageLayer setBorderWidth:1];
        [imageLayer setMasksToBounds:YES];
        [cell.placeImageView sd_setImageWithURL:[NSURL URLWithString:self.place.imageURL]];
        
        [cell.callButton.layer setBorderWidth:1.0f];
        [cell.callButton.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f].CGColor];
        [cell.callButton.layer setCornerRadius:7.0f];
        [cell.callButton addTarget:self action:@selector(callPlace:) forControlEvents:UIControlEventTouchUpInside];
    
        [cell.directionsButton.layer setBorderWidth:1.0f];
        [cell.directionsButton.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f].CGColor];
        [cell.directionsButton.layer setCornerRadius:7.0f];
        [cell.directionsButton addTarget:self action:@selector(showDirections:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    } else if ([((Media *)self.medias[indexPath.row - 1]).type isEqualToString:@"Instagram"]) {
        InstagramTableViewCell *cell = (InstagramTableViewCell *)[tableView dequeueReusableCellWithIdentifier:InstagramCellIdentifier forIndexPath:indexPath];
        
        Instagram *post = (Instagram *)self.medias[indexPath.row];
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:post.imageURL]];
        
        CALayer *imageLayer = cell.userImageView.layer;
        [imageLayer setCornerRadius:cell.userImageView.frame.size.width / 2];
        [imageLayer setBorderWidth:1];
        [imageLayer setMasksToBounds:YES];
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:post.profileImageURL]];
        
        cell.usernameLabel.text = post.username;
        
        cell.timestampLabel.text = [post.createdAt description];
        
        return cell;
    } else if ([((Media *)self.medias[indexPath.row - 1]).type isEqualToString:@"Twitter"]) {
        TweetTableViewCell *cell = (TweetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TweetCellIdentifier forIndexPath:indexPath];
        
        Tweet *post = (Tweet *)self.medias[indexPath.row];
        
        CALayer *imageLayer = cell.profileImageView.layer;
        [imageLayer setCornerRadius:cell.profileImageView.frame.size.width / 2];
        [imageLayer setBorderWidth:1];
        [imageLayer setMasksToBounds:YES];
        [cell.profileImageView sd_setImageWithURL:[NSURL URLWithString:post.profileImageURL]];
        
        cell.usernameLabel.text = post.username;
        
        cell.tweetTextLabel.text = post.text;
        
        return cell;
    } else {
        NSLog(@"ERROR");
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    Media *post = (Media *)self.medias[indexPath.row - 1];
    if ([post.type isEqualToString:@"Instagram"]) {
        return 445;
    } else {
        return 76;
    }
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
                                                  [self.tableView reloadData];
                                              }
                                              failure: ^(RKObjectRequestOperation *operation, NSError *error) {
                                                  RKLogError(@"Load failed with error: %@", error);
                                              }
     ];
}

@end
