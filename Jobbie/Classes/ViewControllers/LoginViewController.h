//
//  LoginViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/15/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerMethods.h"
#import "Messenger.h"
#import "Model.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

//Interface Elements
@property IBOutlet UIScrollView* scrollView;
@property IBOutlet UITextField* userNameField;
@property IBOutlet UITextField* passwordField;
@property IBOutlet UIButton* loginBtn;
@property IBOutlet UILabel* loginErrorLbl;

//Model Objects
@property ControllerMethods* controllerMethods;

@property AppDelegate* appDelegate;

@end
