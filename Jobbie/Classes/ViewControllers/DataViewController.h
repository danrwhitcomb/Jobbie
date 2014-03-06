//
//  DataViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/17/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataViewControllerDelegate <NSObject>

@optional
-(void) animateToNextCard;

@end


@interface DataViewController : UIViewController
@property (nonatomic, assign) id<DataViewControllerDelegate> delegate;
@end


