//
//  PlaceDetailTableViewCell.m
//  Happnin
//
//  Created by Luke Newman on 3/30/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PlaceDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *directionsButton;

@property (strong, nonatomic) NSArray *medias;

@end

@implementation PlaceDetailViewController 

- (void)viewDidLoad {
    [self.callButton.layer setBorderWidth:1.0f];
    [self.callButton.layer setBorderColor:[UIColor colorWithRed:103 green:58 blue:183 alpha:0.5].CGColor];
    [self.callButton.layer setCornerRadius:10.0f];
    
    [self.directionsButton.layer setBorderWidth:1.0f];
    [self.directionsButton.layer setBorderColor:[UIColor colorWithRed:103 green:58 blue:183 alpha:0.5].CGColor];
    [self.directionsButton.layer setCornerRadius:10.0f];
    
    self.placeImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.place.imageURL]]];
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
