//
//  DataTwoViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/18/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataTwoViewControllerDelegate <NSObject>

@required
-(void) animateToNextCard: (id) sender;

@end

@interface DataTwoViewController : UIViewController
@property (nonatomic, assign) id<DataTwoViewControllerDelegate> delegate;

@end
