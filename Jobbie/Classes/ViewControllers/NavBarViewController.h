//
//  NavBarViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/27/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol NavBarViewControllerDelegate <NSObject>

-(void)onBtnSettings: (id) sender;
-(void)onBtnProfiles: (id) sender;

@end

@interface NavBarViewController : UIViewController

@property id<NavBarViewControllerDelegate> delegate;

@end
