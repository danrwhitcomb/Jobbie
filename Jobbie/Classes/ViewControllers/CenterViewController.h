//
//  CenterViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)movePanelRight;
@required
- (void)movePanelToOriginalPosition;

@end

@interface CenterViewController : UIViewController <LeftViewControllerDelegate>

@property (nonatomic, assign) id<CenterViewControllerDelegate> delegate;

//Buttons and Labels
@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;

- (IBAction)btnMovePanelRight:(id)sender;

@end
