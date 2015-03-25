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

@interface PlaceListTableViewController ()

@property (nonatomic, strong) NSArray *venues;

@end

@implementation PlaceListTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // here's where to set the navigation bar color (hint: this doesn't work yet)
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:103 green:58 blue:183 alpha:1];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:103 green:58 blue:183 alpha:1];
}

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
    
    return cell;
}

#pragma mark - RESTKit

- (void)loadVenuesWithSection:(NSString *)section {
    
    NSLog(@"requesting data with section: %@", section);
    
    NSDictionary *parameters = @{
                                 @"loc": @"33.782139,-84.382166",
                                 @"radius": @"1500",
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
