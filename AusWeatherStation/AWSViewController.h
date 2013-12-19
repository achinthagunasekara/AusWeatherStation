//
//  AWSViewController.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWSAppDelegate.h"

@interface AWSViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *cities;
    NSMutableArray *currentLocation;
    AWSAppDelegate *delegate;
    NSArray *list;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UIBarButtonItem *editButton;

- (IBAction)enterEditMode:(id)sender;

@end
