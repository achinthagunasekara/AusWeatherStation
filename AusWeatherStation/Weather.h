//
//  Weather.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 31/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *currentTemp;
@property (nonatomic, strong) NSString *minTemp;
@property (nonatomic, strong) NSString *maxTemp;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *windSpeed;

@end