//
//  EmbedDataViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 2/8/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "EmbedDataViewController.h"



@interface EmbedDataViewController ()

- (IBAction)swapButtonPressed:(id)sender;
@end

@implementation EmbedDataViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        _delegate = segue.destinationViewController;
    }
}

- (IBAction)swapButtonPressed:(id)sender
{
    if(sender ==  _infoBtn){
        [_delegate swapViewControllers: @"embedSecond"];
    } else {
        [_delegate swapViewControllers: @"embedFirst"];
    }
}

@end