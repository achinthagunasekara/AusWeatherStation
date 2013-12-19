//
//  RootViewController.h
//  AusWeatherStation
//
//  Created by Achintha Gunasekara on 8/10/13.
//  Copyright (c) 2013 Achintha Gunasekara (S3369984). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)titles;

@end