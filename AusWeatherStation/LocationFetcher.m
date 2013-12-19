//
//  LocationFetcher.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 30/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "LocationFetcher.h"

@implementation LocationFetcher

CLLocation *currentLocation;
CLPlacemark *placemark;

-(void)getCurrentCityWeather {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 5;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    currentLocation = [locations lastObject];
    CLGeocoder *geocoder;
    
    geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            
            placemark = [placemarks lastObject];
            City *currentCity = [[City alloc] init];
            currentCity.cityName = placemark.locality;
            currentCity.country = placemark.country;
            
            [self.locationManager stopUpdatingLocation];
            [self.cController setupScreen:currentCity];
            [self.cController setThisCity:currentCity];
        }
        else {
            
            [self.locationManager stopUpdatingLocation];
            [self showError:@"Unable to get current location"];
        }
    } ];
}

//used to debug location related errors
- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error {
    
    [self showError:@"Location service error"];
}

-(void)showError:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
}

@end
