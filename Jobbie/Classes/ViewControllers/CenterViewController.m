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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _controllerMethods = [[ControllerMethods alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInterfaceElements];
}

- (void)setupInterfaceElements
{
    //Setup UIImageView attributes
    CALayer *imageLayer = [_jobImage layer];
    [imageLayer setMasksToBounds:YES];
    [imageLayer setCornerRadius:_jobImage.frame.size.width/2];
    [imageLayer setBorderWidth:4.0];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [imageLayer setBorderColor:CGColorCreate(colorSpace, (CGFloat[]){38/255.0, 185/255.0, 154/255.0, 1.0})];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)toggleScrollViewPage:(id)sender
{
    if(true){
        NSLog(@"Hit info button");
    }
        
}
@end
