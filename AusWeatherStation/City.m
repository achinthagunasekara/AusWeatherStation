//
//  City.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "City.h"

@implementation City

 @synthesize cityName;

+ (id)cityName:(NSString *)name
{
    City *newCity = [[self alloc] init];
    newCity.cityName = name;
    return newCity;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.cityName forKey:@"cityName"];
    [encoder encodeObject:self.country forKey:@"country"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    
    if (self = [super init]) {
        
        self.cityName = [decoder decodeObjectForKey:@"cityName"];
        self.country = [decoder decodeObjectForKey:@"country"];
    }

    return self;
}

@end