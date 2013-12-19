//
//  City.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject <NSCoding>

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *country;

+ (id)cityName:(NSString *)name;

@end
