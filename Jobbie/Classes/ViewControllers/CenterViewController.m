//
//  CenterViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()
@end

@implementation CenterViewController

@synthesize headerLabel = _headerLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)btnMovePanelRight:(id)sender
{
    UIButton* button = sender;
    
    //Initial tag is set to 1, and gets toggled after
    //each call.
    switch(button.tag){
        case 0: {
            [_delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            [_delegate movePanelRight];
            break;
        }
        
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInterfaceElements];
    
}

- (void)setupInterfaceElements
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
