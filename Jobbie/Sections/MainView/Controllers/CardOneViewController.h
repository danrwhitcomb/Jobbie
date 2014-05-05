//
//  CardOneViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/26/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardWebViewController;
@class CardOneMainViewController;

@protocol CardOneViewControllerDelegate <NSObject>

-(void)animateCardSwipe: (id)sender;
-(void)animateShuffledCard;

@end

@interface CardOneViewController : UIViewController 

@property id<CardOneViewControllerDelegate> delegate;
- (void)swapViewControllers: (UIViewController*) controller;

@property CardWebViewController* webViewController;
@property CardOneMainViewController* mainController;

-(void) showNoResults;
-(void) showResults;

@end
