//
//  CenterViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "ControllerMethods.h"
#import "DataViewController.h"
#import "Messenger.h"
#import "Model.h"

@protocol CenterViewControllerDelegate <NSObject>
@optional
- (void)movePanelRight;
@required
- (void)movePanelToOriginalPosition;

@end

@interface CenterViewController : UIViewController 
@property (nonatomic, assign) id<CenterViewControllerDelegate> delegate;

//Buttons and Labels
@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *profileButton;

//ImageView
@property (nonatomic, strong) IBOutlet UIImageView *jobImage;


@property ControllerMethods* controllerMethods;

@property Messenger* messenger;
@property Model* model;

- (IBAction)btnMovePanelRight:(id)sender;

@end
