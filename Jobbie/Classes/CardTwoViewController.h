//
//  CardTwoViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/26/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardTwoViewControllerDelegate <NSObject>

-(void)animateCardSwipe: (id)sender;

@end


@interface CardTwoViewController : UIViewController

@property id<CardTwoViewControllerDelegate> delegate;

@end
