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
#import "PlaceCell.h"
#import "PlaceDetailTableViewController.h"

@interface PlaceListTableViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation PlaceListTableViewController

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    Place *place = self.venues[indexPath.row];
    
    // name
    cell.nameLabel.text = place.name;
    
    // image
    CALayer *imageLayer = cell.placeImage.layer;
    [imageLayer setCornerRadius:cell.placeImage.frame.size.width / 2];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];
    cell.placeImage.image = [UIImage imageWithData:place.imageData];
    
    // is it closed?
    if (place.isClosed) {
        cell.isClosedLabel.text = @"Closed";
    } else {
        cell.isClosedLabel.text = @"Open now";
    }
    
    // display street address only
    NSMutableString *displayAddress = [[NSMutableString alloc] init];
    [displayAddress appendString:place.addressArray[0]];
    if (place.addressArray.count > 3) {
        [displayAddress appendFormat:@", %@", place.addressArray[1]];
    }
    cell.addressLabel.text = displayAddress;
    
    return cell;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlaceDetailTableViewController *destViewController = (PlaceDetailTableViewController *)[segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"showPlaceDetail"]) {
        NSIndexPath *selectedPlaceIndex = [self.tableView indexPathForSelectedRow];
        destViewController.place = self.venues[selectedPlaceIndex.row];
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
         self.venues = mappingResult.array;
         [self.tableView reloadData];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}

@end
