//
//  CardTwoViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/26/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardWebViewController.h"

@class CardTwoMainViewController;

@protocol CardTwoViewControllerDelegate <NSObject>

-(void)animateCardSwipe: (id)sender;
-(void)animateShuffledCard;
-(void)swapViewControllers:(UIViewController*)controller;


@end


@interface CardTwoViewController : UIViewController

@property id<CardTwoViewControllerDelegate> delegate;
@property CardTwoMainViewController* mainController;

-(void)swapViewControllers:(UIViewController*)controller;

-(void) showNoResults;
-(void) showResults;

@end
