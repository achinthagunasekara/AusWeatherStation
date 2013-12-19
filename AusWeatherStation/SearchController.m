//
//  SearchController.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 5/10/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "SearchController.h"
#import "CityController.h"

@interface SearchController ()

@end

@implementation SearchController

@synthesize citySearchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    delegate = (AWSAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (self) {
        
        self.title = @"City Search";
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_search.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"tab_search.png"]];
        [self.tabBarItem setTitle:@"Search"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    City* city;
    NSArray* list = [self readFile];
    cities = [[NSMutableArray alloc] initWithCapacity:[list count]];
    int i = 0;
    
    for (id obj in list) {
        
        NSArray* cityDetails = [obj componentsSeparatedByString:@";"];
        city = [City cityName:[cityDetails objectAtIndex:0]];
        city.country = [cityDetails objectAtIndex:0];
        
        [cities insertObject:city atIndex:i];
        i++;
    }
    
    filteredCities = [NSMutableArray arrayWithCapacity:[cities count]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
    
    if(nil == cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    City *thisCity;
    
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tv == self.searchDisplayController.searchResultsTableView) {
        
        thisCity = [filteredCities objectAtIndex:indexPath.row];
    }
    else {
        
        thisCity = [cities objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = thisCity.cityName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    
    if (tv == self.searchDisplayController.searchResultsTableView) {
        
        return [filteredCities count];
    }
    else {
        
        return [cities count];
    }
}

-(void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CityController *cityController;
    City *city;
    
    if (tv == self.searchDisplayController.searchResultsTableView) {
        
        city = [filteredCities objectAtIndex:indexPath.row];
    }
    else {
        
        city = [cities objectAtIndex:indexPath.row];
    }
    
    city.country = @"Australia";
    cityController = [[CityController alloc] initWithCity:city typeOfLocation:@"city"];
    
    [delegate.navControllerSearch pushViewController:cityController animated:YES];
    
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Content Filtering

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [filteredCities removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.cityName contains[c] %@",searchText];
    filteredCities = [NSMutableArray arrayWithArray:[cities filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    //Cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    //Cause the search result table view to be reloaded.
    return YES;
}

-(NSArray*)readFile {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"cities"
                                                     ofType:@"csv"];
    NSString* fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray* lines = [fileContents componentsSeparatedByString:@"\n"];
    
    return lines;
}

@end