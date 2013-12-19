//
//  CityController.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "CityController.h"
#import "WeatherFetcher.h"
#import "LocationFetcher.h"

@interface CityController ()

@end

@implementation CityController

WeatherFetcher *fetcher;
LocationFetcher *locFetcher;

- (id)initWithCity: (City *)selectedCity typeOfLocation:(NSString *)type{
    
    if((self = [super init])) {
        
        city = selectedCity;
    }
    
    self.type = type;
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    delegate = (AWSAppDelegate *)[[UIApplication sharedApplication] delegate];

    fetcher = [[WeatherFetcher alloc] init];
    fetcher.cController = self;

    locFetcher = [[LocationFetcher alloc] init];
    locFetcher.cController = self;

    [self setupForCityOrCurrentLocation];
}

-(void)setupForCityOrCurrentLocation {

    if([self.type isEqualToString:@"loc"]) {
    
        self.thisCity = [delegate.currentLocation objectAtIndex:index.row];
        [locFetcher getCurrentCityWeather];
    }
    else {
        
        self.thisCity = city;
        [self setupScreen:self.thisCity];
    }
}

- (void)setupScreen:(City *)tmpCity {
    
    self.title = tmpCity.cityName;
    pictureView.image = [UIImage imageNamed:@"current_loc.png"];
    
    [fetcher fetchWeather:tmpCity.cityName countryName:tmpCity.country];
}

- (IBAction)displayMenu:(id)sender {
    
    bool inFavourites = NO;
    
    for(City *c in delegate.cities) {
        
        if([c.cityName isEqualToString:self.thisCity.cityName]) {
            
            inFavourites = YES;
        }
    }
    
    if(inFavourites) {
        
        self.actionSheet = [[UIActionSheet alloc]
                                    initWithTitle:@"Options"
                                    delegate:self
                                    cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles:@"Refresh", @"Post On Facebook", @"Post On Twitter", nil];
    }
    else {

        self.actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Options"
                                      delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"Refresh", @"Post On Facebook", @"Post On Twitter", @"Add to Favourites", nil];
        
    }
    
    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [self.actionSheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if([self.actionSheet cancelButtonIndex] != buttonIndex) {
    
        switch (buttonIndex) {
                
            case 0:
                [self setupForCityOrCurrentLocation];
                break;
            case 1:
                [self postToFacebook];
                break;
            case 2:
                [self postToTwitter];
                break;
            case 3:
                [delegate addCity:self.thisCity];
                [delegate saveCities];
                break;
        }
    }
}

- (void)postToTwitter {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[self getWeatherStringForPosting]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (void)postToFacebook {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[self getWeatherStringForPosting]];
        [controller addImage:[UIImage imageNamed:@"icon_retna.png"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (NSString*) getWeatherStringForPosting {
    
    NSString *weatherString = @"Current weather details at ";
    
    @try {
    
        weatherString = [weatherString stringByAppendingString:weather.location];
        weatherString = [weatherString stringByAppendingString:@" is : Temperature - "];
        weatherString = [weatherString stringByAppendingString:weather.currentTemp];
        weatherString = [weatherString stringByAppendingString:@" , Max Temperature - "];
        weatherString = [weatherString stringByAppendingString:weather.maxTemp];
        weatherString = [weatherString stringByAppendingString:@" , Min Temperature - "];
        weatherString = [weatherString stringByAppendingString:weather.minTemp];
        weatherString = [weatherString stringByAppendingString:@" - by AWS"];
    }
    @catch (NSException *exception) {
        
        //Can not obtain information
        NSLog(@"%@", exception.reason);
    }
    
    return  weatherString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateScreen {
    
    weather = [fetcher getWeather];
    location.text = weather.location;
    currentTemp.text = weather.currentTemp;
    minTemp.text = weather.minTemp;
    maxTemp.text = weather.maxTemp;
    humidity.text = weather.humidity;
    pressure.text = weather.pressure;
    windSpeed.text = weather.windSpeed;
}

-(void)showError:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
}

@end
