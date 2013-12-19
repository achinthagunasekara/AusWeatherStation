//
//  AWSAppDelegate.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "City.h"

@class AWSViewController;

@interface AWSAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate> {
    
    AWSViewController *mainView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AWSViewController *viewController;
@property (strong, nonatomic) UINavigationController *navControllerMain;
@property (strong, nonatomic) UINavigationController *navControllerSearch;
@property (strong, nonatomic) UINavigationController *navControllerAbout;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) NSMutableArray *cities;
@property (strong, nonatomic) NSMutableArray *currentLocation;
@property (strong, nonatomic) NSString *dataFile;

@property (strong, nonatomic) NSMutableArray *tmpCityList;

- (void)addCity:(City *) city;
- (void)saveCities;

@end
