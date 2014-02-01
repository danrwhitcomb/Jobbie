//
//  LeftViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ControllerMethods.h"

@protocol LeftViewControllerDelegate <NSObject>
@end

@interface LeftViewController : UITableViewController
@property (nonatomic, strong) id<LeftViewControllerDelegate> delegate;

//TableCells
@property (strong, nonatomic) IBOutlet UITableViewCell *opportunitiesCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *matchesCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *profileCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *settingsCell;

@property ControllerMethods* controllerMethods;

@end
