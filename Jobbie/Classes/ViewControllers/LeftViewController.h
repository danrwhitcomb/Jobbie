//
//  LeftViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LeftViewControllerDelegate <NSObject>
@end

@interface LeftViewController : UIViewController
@property (nonatomic, strong) id<LeftViewControllerDelegate> delegate;
@end
