//
//  EmbedDataTwoViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 3/18/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "EmbedDataTwoViewController.h"


@interface EmbedDataTwoViewController ()

- (IBAction)swapButtonPressed:(id)sender;
@end



@implementation EmbedDataTwoViewController

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
