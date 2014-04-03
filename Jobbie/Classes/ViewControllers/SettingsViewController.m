//
//  SettingsViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 3/31/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "SettingsViewController.h"
#define FADE_TIMING .25

@implementation SettingsViewController

-(void)viewDidLoad
{
    [self.view setTintColor:[UIColor blackColor]];
}

- (IBAction)onBtnClose:(id)sender
{
    NSLog(@"Closing Settings");
    [UIView animateWithDuration:FADE_TIMING animations:^{
        self.view.alpha = 0;
    }];
    //[self.view removeFromSuperview];
}

@end
