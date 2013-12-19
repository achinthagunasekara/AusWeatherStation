//
//  AWSAppDelegate.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 11/08/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "AWSAppDelegate.h"
#import "AWSViewController.h"
#import "SearchController.h"
#import "AboutViewController.h"

@implementation AWSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //show splash image for 3 seconds
    sleep(1.5);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.dataFile = [documentsDirectory stringByAppendingPathComponent:@"AppData"];
    
    self.cities = [[NSMutableArray alloc] init];
    
    if([[NSKeyedUnarchiver unarchiveObjectWithFile:self.dataFile] count] > 0) {
    
        self.cities = [NSKeyedUnarchiver unarchiveObjectWithFile:self.dataFile];
    }
    
    City *currentLoc = [[City alloc] init];
    currentLoc.cityName = @"Current Location";
    currentLoc.country = @"N/A";
    
    self.currentLocation = [[NSMutableArray alloc] initWithObjects: currentLoc, nil];
    
    mainView = [[AWSViewController alloc] initWithNibName:@"AWSViewController" bundle:nil];
    self.navControllerMain =[[UINavigationController alloc] initWithRootViewController:mainView];
    
    self.navControllerMain.navigationBar.tintColor = [UIColor blackColor];
    self.navControllerMain.navigationBar.alpha = 0.7f;
    self.navControllerMain.navigationBar.translucent = NO;
    
    SearchController *cSearch = [[SearchController alloc] initWithNibName:@"SearchController" bundle:nil];
    self.navControllerSearch = [[UINavigationController alloc] initWithRootViewController:cSearch];
    
    self.navControllerSearch.navigationBar.tintColor = [UIColor blackColor];
    self.navControllerSearch.navigationBar.alpha = 0.7f;
    self.navControllerSearch.navigationBar.translucent = NO;
    
    AboutViewController *about = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    self.navControllerAbout = [[UINavigationController alloc] initWithRootViewController:about];
    
    self.navControllerAbout.navigationBar.tintColor = [UIColor blackColor];
    self.navControllerAbout.navigationBar.alpha = 0.7f;
    self.navControllerAbout.navigationBar.translucent = NO;
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.navControllerMain, self.navControllerSearch, self.navControllerAbout, nil];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)addCity:(City *) city {
    
    [self.cities addObject:city];
    [mainView.tableView reloadData];
    [mainView.tabBarItem setBadgeValue:@"New"];
}

- (void)saveCities {

    [NSKeyedArchiver archiveRootObject:self.cities toFile:self.dataFile];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if(viewController == self.navControllerMain){
        
        [mainView.tabBarItem setBadgeValue:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
