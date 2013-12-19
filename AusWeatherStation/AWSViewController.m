//
//  AWSViewController.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "AWSViewController.h"
#import "City.h"
#import "CityController.h"

@interface AWSViewController ()

@end

@implementation AWSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"Weather Station";
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_weather.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"tab_weather.png"]];
        [self.tabBarItem setTitle:@"Weather"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    delegate = (AWSAppDelegate *)[[UIApplication sharedApplication] delegate];
    cities = delegate.cities;
    currentLocation = delegate.currentLocation;
    
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(enterEditMode:)];
    self.navigationItem.rightBarButtonItem = self.editButton;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark UITTableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
    
    if(nil == cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if(indexPath.section == 0) {
        
        City *thisCity = [currentLocation objectAtIndex:indexPath.row];
        cell.textLabel.text = thisCity.cityName;
    }
    else {
        
        City *thisCity = [cities objectAtIndex:indexPath.row];
        cell.textLabel.text = thisCity.cityName;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if(section == 0) {
        
        return @"My Current Location";
    }
    else {
        return @"Favourites";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if(section == 0) {
        
        return [currentLocation count];
    }
    else {
        
        return [cities count];
    }
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityController *cController;

    if(indexPath.section == 0) {
        
        cController = [[CityController alloc] initWithCity:[currentLocation objectAtIndex:indexPath.row] typeOfLocation:@"loc"];
    }
    else {
        
        cController = [[CityController alloc] initWithCity:[cities objectAtIndex:indexPath.row] typeOfLocation:@"city"];
    }
    
    [delegate.navControllerMain pushViewController:cController animated:YES];
    
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        
            return NO;
    }
    
    return YES;
}

- (IBAction)enterEditMode:(id)sender {
    
    if ([self.tableView isEditing]) {
        
        // If the tableView is already in edit mode, turn it off. Also change the title of the button
        [self.tableView setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit"];
    }
    else {
        
        [self.editButton setTitle:@"Done"];
        // Turn on edit mode
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [cities removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        [delegate saveCities];
    }
}

#pragma mark UITTableViewDelegate Methods

@end
