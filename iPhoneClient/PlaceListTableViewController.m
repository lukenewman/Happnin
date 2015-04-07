//
//  MasterViewController.m
//  iPhoneClient
//
//  Created by Luke Newman on 2/26/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceListTableViewController.h"
#import <RestKit/RestKit.h>

#import "Place.h"
#import "PlaceCell.h"
#import "PlaceDetailViewController.h"

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
    cell.nameLabel.text = place.name;
    cell.placeImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:place.imageURL]]];
    if (place.isClosed) {
        cell.isClosedLabel.text = @"Closed";
    } else {
        cell.isClosedLabel.text = @"Open now";
    }
    cell.addressLabel.text = place.address;
    
    return cell;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlaceDetailViewController *destViewController = (PlaceDetailViewController *)[segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"showPlaceDetail"]) {
        NSIndexPath *selectedPlaceIndex = [self.tableView indexPathForSelectedRow];
        NSLog(@"self.venues[selectedPlaceIndex.row] = %@", self.venues[selectedPlaceIndex.row]);
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
