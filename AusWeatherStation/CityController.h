//
//  CityController.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "AWSAppDelegate.h"
#import "City.h"
#import "Weather.h"


@interface CityController : UIViewController <UIActionSheetDelegate> {
    
    NSIndexPath *index;
    City *city;
    AWSAppDelegate *delegate;
    Weather *weather;
    
    IBOutlet UIImageView *pictureView;
    IBOutlet UILabel *location;
    IBOutlet UILabel *currentTemp;
    IBOutlet UILabel *minTemp;
    IBOutlet UILabel *maxTemp;
    IBOutlet UILabel *humidity;
    IBOutlet UILabel *pressure;
    IBOutlet UILabel *windSpeed;
}

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) City *thisCity;
@property (nonatomic, strong) NSString *type;

- (void)setupScreen:(City *)tmpCity;
- (void)updateScreen;
- (id)initWithCity:(City *)selectedCity typeOfLocation:(NSString *)type;
- (IBAction)displayMenu:(id)sender;
- (void)postToTwitter;
- (void)postToFacebook;

@end
