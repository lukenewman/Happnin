//
//  MasterViewController.m
//  iPhoneClient
//
//  Created by Luke Newman on 2/26/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceListTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>
#import "Place.h"
#import "PlaceTableViewCell.h"
#import "PlaceDetailTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlaceListTableViewController ()

@property (nonatomic, strong) NSArray *places;

@end

@implementation PlaceListTableViewController

static NSString *PlaceCellIdentifier = @"PlaceCell";

- (void)viewDidLoad {
//    [self.tableView registerClass:[PlaceTableViewCell class] forCellReuseIdentifier:PlaceCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceCell" bundle:nil] forCellReuseIdentifier:PlaceCellIdentifier];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceCellIdentifier forIndexPath:indexPath];
    Place *place = self.places[indexPath.row];
    
    // name
    cell.nameLabel.text = place.name;
    
    // image
    [cell.placeImageView sd_setImageWithURL:[NSURL URLWithString:place.imageURL]
                           placeholderImage:[UIImage imageNamed:@"barbuttonicon"]];
    CALayer *imageLayer = cell.placeImageView.layer;
    [imageLayer setCornerRadius:cell.placeImageView.frame.size.width / 2];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];
    
    // display rating
    NSString *ratingString = [NSString stringWithFormat:@"⭐️%@", place.rating];
    cell.ratingLabel.text = ratingString;
    
    // display street address only
    NSMutableString *displayAddress = [[NSMutableString alloc] init];
    [displayAddress appendString:place.addressArray[0]];
    if (place.addressArray.count > 3) {
        [displayAddress appendFormat:@", %@", place.addressArray[1]];
    }
    cell.addressLabel.text = displayAddress;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showPlaceDetail" sender:self.tableView];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlaceDetailTableViewController *destViewController = (PlaceDetailTableViewController *)[segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"showPlaceDetail"]) {
        NSIndexPath *selectedPlaceIndex = [self.tableView indexPathForSelectedRow];
        destViewController.place = self.places[selectedPlaceIndex.row];
        [destViewController loadMedia];
    }
}

#pragma mark - RESTKit

- (void)loadVenuesWithSection:(NSString *)section {
    NSDictionary *parameters = @{
                                 @"loc": @"33.782139,-84.382166",
                                 @"section": section
                                 };
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/places"
                                           parameters:parameters
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         self.places = mappingResult.array;
         [self.tableView reloadData];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}

@end
