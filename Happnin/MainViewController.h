//
//  MainViewController.h
//  iPhoneClient
//
//  Created by Luke Newman on 3/15/15.
//  Copyright (c) 2015 Luke Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController <CLLocationManagerDelegate, UISearchBarDelegate> {
    CLLocationManager *locationManager;
}

@end
