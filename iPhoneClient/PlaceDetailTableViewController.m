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
#import "InstagramTableViewCell.h"
#import "TweetTableViewCell.h"

@interface PlaceDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *directionsButton;

@property (strong, nonatomic) NSArray *medias;

@end

@implementation PlaceDetailTableViewController 

- (void)viewDidLoad {
    self.navigationController.hidesBarsOnSwipe = NO;
    self.navigationItem.title = self.place.name;
    
    // put this in cell for row at index path
//    [self.callButton.layer setBorderWidth:1.0f];
//    [self.callButton.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f].CGColor];
//    [self.callButton.layer setCornerRadius:7.0f];
//    
//    [self.directionsButton.layer setBorderWidth:1.0f];
//    [self.directionsButton.layer setBorderColor:[UIColor colorWithRed:103.0/255.0 green:58.0/255.0 blue:183.0/255.0 alpha:1.0f].CGColor];
//    [self.directionsButton.layer setCornerRadius:7.0f];
//    
//    CALayer *imageLayer = self.placeImage.layer;
//    [imageLayer setCornerRadius:10.0f];
//    [imageLayer setBorderWidth:1];
//    [imageLayer setMasksToBounds:YES];
//    self.placeImage.image = [UIImage imageWithData:self.place.imageData];
//    
//    self.nameLabel.text = self.place.name;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    }
    return self.medias.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceDetailCell" forIndexPath:indexPath];
//        
//        // setup the Place detail cell
//        
//        return cell;
//    }
    // else
    if ([((Media *)self.medias[indexPath.row]).type isEqualToString:@"Instagram"]) {
        InstagramTableViewCell *cell = (InstagramTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"InstagramCell" forIndexPath:indexPath];
        Instagram *post = (Instagram *)self.medias[indexPath.row];
        
        // setup the Instagram media cell
        NSURL *postImageURL = [NSURL URLWithString:post.imageURL];
        NSData *postImageData = [NSData dataWithContentsOfURL:postImageURL];
        cell.postImageView.image = [UIImage imageWithData:postImageData];
        
        NSURL *userImageURL = [NSURL URLWithString:post.profileImageURL];
        NSData *userImageData = [NSData dataWithContentsOfURL:userImageURL];
        cell.userImageView.image = [UIImage imageWithData:userImageData];
        
        cell.usernameLabel.text = post.username;
        
        cell.timestampLabel.text = [post.createdAt description];
        
        return cell;
    } else if ([((Media *)self.medias[indexPath.row]).type isEqualToString:@"Tweet"]) {
        TweetTableViewCell *cell = (TweetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
        Tweet *post = (Tweet *)self.medias[indexPath.row];
        
        // setup the Tweet media cell
        NSURL *profileImageURL = [NSURL URLWithString:post.profileImageURL];
        NSData *profileImageData = [NSData dataWithContentsOfURL:profileImageURL];
        cell.profileImageView.image = [UIImage imageWithData:profileImageData];
        
        cell.usernameLabel.text = post.username;
        
        cell.tweetTextLabel.text = post.text;
        
        return cell;
    } else {
        // some error -- not sure what to do in this case
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Media *post = (Media *)self.medias[indexPath.row];
    if ([post.type isEqualToString:@"Instagram"]) {
        return 445;
    } else {
        return 183;
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
                                                  NSLog(@"self.medias: %@", self.medias);
                                              }
                                              failure: ^(RKObjectRequestOperation *operation, NSError *error) {
                                                  RKLogError(@"Load failed with error: %@", error);
                                              }
     ];
}

@end
