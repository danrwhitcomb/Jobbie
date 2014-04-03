//
//  EmbedDataTwoViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/18/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmbedDataTwoViewControllerDelegate <NSObject>

@optional
-(void) swapViewControllers: (NSString*)tag;

@end

@interface EmbedDataTwoViewController : UIViewController

@property (nonatomic, assign) id<EmbedDataTwoViewControllerDelegate> delegate;

@property IBOutlet UIButton* infoBtn;
@property IBOutlet UIButton* backBtn;
@end
