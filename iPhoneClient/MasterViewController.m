//
//  MasterViewController.m
//  iPhoneClient
//
//  Created by Luke Newman on 2/26/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

#import "PlaceList.h"
#import "Place.h"

@interface MasterViewController ()

@property NSArray *venues;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // here's where to set the navigation bar color (hint: this doesn't work yet)
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:103 green:58 blue:183 alpha:1];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:103 green:58 blue:183 alpha:1];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Place *place = self.venues[indexPath.row];
        [[segue destinationViewController] setDetailItem:place.name];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Place *place = self.venues[indexPath.row];
    cell.textLabel.text = place.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark - RESTKit

- (void)requestData {
    
    NSString *requestPath = @"/places";
    
    NSDictionary *parameters = @{
                                 @"loc": @"33.782139,-84.382166",
                                 @"radius": @"1500",
                                 @"section": @"restaurants",
                                 @"sort": @"2",
                                 @"limit": @"20"
                                 };
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:parameters
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //places have been saved in core data by now
         [self fetchPlacesFromContext];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
}

- (void)fetchPlacesFromContext {
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PlaceList"];
    
//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES];
//    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    PlaceList *placeList = [fetchedObjects firstObject];
    
    self.venues = [placeList.places allObjects];
    
    NSLog(@"VENUES: %@", self.venues);
    
    [self.tableView reloadData];
}

@end
