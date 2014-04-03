//
//  DataViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/17/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"

@protocol DataViewControllerDelegate <NSObject>

@required
-(void) animateToNextCard: (id) sender;

@end


@interface DataViewController : UIViewController
@property (nonatomic, assign) id<DataViewControllerDelegate> delegate;
@end


