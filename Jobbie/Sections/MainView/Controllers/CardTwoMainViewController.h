//
//  CardTwoMainViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 4/4/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardTwoMainViewControllerDelegate <NSObject>

-(void) swapViewControllers: (UIViewController*)sender;
- (void)onBtnShuffle;


@end

@interface CardTwoMainViewController : UIViewController

@property IBOutlet UIButton* infoButton;
@property IBOutlet UIButton* stackButton;

@property id<CardTwoMainViewControllerDelegate> delegate;
-(void)loadJobFromIndex:(int) ind;

@end
