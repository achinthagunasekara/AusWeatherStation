//
//  LocationFetcher.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 30/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CityController.h"
#import "City.h"

@interface LocationFetcher : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CityController *cController;

- (void)getCurrentCityWeather;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error;

@end