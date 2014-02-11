//
//  EmbedDataViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 2/8/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmbedDataViewControllerDelegate <NSObject>

@optional
-(void) swapViewControllers: (NSString*)tag;

@end

@interface EmbedDataViewController : UIViewController

@property (nonatomic, assign) id<EmbedDataViewControllerDelegate> delegate;

@property IBOutlet UIButton* infoBtn;
@property IBOutlet UIButton* backBtn;

@end
