//
//  WeatherFetcher.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 26/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityController.h"
#import "Weather.h"

@interface WeatherFetcher : NSObject {

}

@property (nonatomic, strong) CityController *cController;
@property (nonatomic, strong) NSMutableDictionary *weatherData;

- (void)fetchWeather:(NSString *)cityName countryName:(NSString *)country;
- (Weather *)getWeather;

@end