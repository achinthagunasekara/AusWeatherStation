//
//  SearchController.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 5/10/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWSAppDelegate.h"
#import "City.h"

@interface SearchController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {

    AWSAppDelegate *delegate;
    NSMutableArray *cities;
    NSMutableArray *filteredCities;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property IBOutlet UISearchBar *citySearchBar;

-(NSArray*)readFile;

@end
