//
//  ViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerMethods.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "CardOneViewController.h"
#import "CardTwoViewController.h"
#import "Messenger.h"
#import "AppDelegate.h"
#import "UIActivityIndicatorView+AFNetworking.h"


@interface MainViewController : UIViewController <UIGestureRecognizerDelegate, CardOneViewControllerDelegate, CardTwoViewControllerDelegate>

-(void)animateShuffledCard;

@end
