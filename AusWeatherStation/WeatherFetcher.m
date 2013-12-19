//
//  WeatherFetcher.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 26/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "WeatherFetcher.h"
#import <CoreLocation/CoreLocation.h>

@implementation WeatherFetcher

- (void)fetchWeather:(NSString *)cityName countryName:(NSString *)country;
{
    
    NSString *urlString = @"http://api.openweathermap.org/data/2.5/weather?q='";
    urlString = [urlString stringByAppendingString:cityName];
    urlString = [urlString stringByAppendingString:@"','"];
    urlString = [urlString stringByAppendingString:country];
    urlString = [urlString stringByAppendingString:@"'&units=metric"];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError)
                               {
                                   [self handleNetworkErorr:connectionError];
                               }
                               else
                               {
                                   [self handleNetworkResponse:data];
                               }
                           }];
}

#pragma mark - Private Failure Methods

- (void)handleNetworkErorr:(NSError *)error {

    [self showError:@"Network Issue, please try again later"];
}

-(void)showError:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
}

#pragma mark - Private Success Methods

- (void)handleNetworkResponse:(NSData *)myData
{
    //NSMutableDictionary *data = [NSMutableDictionary dictionary];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    // now we'll parse our data using NSJSONSerialization
    id myJSON = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    // typecast an array and list its contents
    NSDictionary *jsonArray = (NSDictionary *)myJSON;
    
    // take a look at all elements in the array
    for (id element in jsonArray) {
        
        id key = [element description];
        
        id innerArr = [jsonArray objectForKey:key];
        
        NSDictionary *inner = (NSDictionary *)innerArr;
        
        if ([inner conformsToProtocol:@protocol(NSFastEnumeration)]) {
            
            for(id ele in inner) {
                
                if ([ele conformsToProtocol:@protocol(NSFastEnumeration)]) {
                    
                    NSDictionary *innerInner = (NSDictionary *)ele;
                    
                    for(id eleEle in innerInner) {
                        
                        id innerInnerKey = [eleEle description];
                        [data setObject:[[inner valueForKey:innerInnerKey] description] forKey:[eleEle description]];
                    }
                }
                else {
                    
                    id innerKey = [ele description];
                    [data setObject:[[inner valueForKey:innerKey] description] forKey:[ele description]];
                }
            }
        }
        else {
            
            [data setObject:[inner description] forKey:[element description]];
        }
    }
    
    self.weatherData = data;
    [self.cController updateScreen];
}

-(Weather *)getWeather {

    Weather *weather = [[Weather alloc] init];
    
    @try {
 
        if([self.weatherData valueForKey:@"name"] == nil) {
            
            [NSException raise:NSInvalidArgumentException format:@"invalid weather data"];
        }
        
        NSString *location = [[self.weatherData valueForKey:@"name"] description];
        location = [location stringByAppendingString:@", "];
        location = [location stringByAppendingString:[[self.weatherData valueForKey:@"country"] description]];
        weather.location = location;
    
        weather.currentTemp = [self trimTemp:[[self.weatherData valueForKey:@"temp"] description]];
        weather.minTemp = [self trimTemp:[[self.weatherData valueForKey:@"temp_min"] description]];
        weather.maxTemp = [self trimTemp:[[self.weatherData valueForKey:@"temp_max"] description]];
        
        NSString *humidity = [[self.weatherData valueForKey:@"humidity"] description];
        humidity = [humidity stringByAppendingString:@"%"];
        weather.humidity = humidity;
        
        NSString *pressure = [[self.weatherData valueForKey:@"pressure"] description];
        pressure = [pressure stringByAppendingString:@"PA"];
        weather.pressure = pressure;
        
        NSString *windSpeed = [[self.weatherData valueForKey:@"speed"] description];
        windSpeed = [windSpeed stringByAppendingString:@"Kmph"];
        weather.windSpeed = windSpeed;
    }
    @catch (NSException *exception)
    {
       [self showError:@"No weater data available for your location"];
    }
    
    return weather;
}

-(NSString*)trimTemp:(NSString*)temp {
    
    NSString *val;
    
    //remove decimal places
    if([temp length] > 2) {
        
        val = [temp substringWithRange:NSMakeRange(0, 2)];
    }
    else {
        
        val = temp;
    }
    
    val = [val stringByAppendingString:@"C"];
    
    return val;
}

@end