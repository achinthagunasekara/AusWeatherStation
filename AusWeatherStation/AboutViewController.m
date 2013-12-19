//
//  AboutViewController.m
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 29/09/13.
//  Copyright (c) 2013 Archie Gunasekara. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        
        self.title = @"About";
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_about.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"tab_about.png"]];
        [self.tabBarItem setTitle:@"about"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myHome:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.achintha.net.au"];
    [[UIApplication sharedApplication] openURL:url];
}

@end
