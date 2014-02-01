//
//  SecondaryViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/5/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "SecondaryViewController.h"

@interface SecondaryViewController ()

@end

@implementation SecondaryViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//IBACTIONS!

//General
- (IBAction)returnToMainView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Settings
-(IBAction)logoutOfAccount:(id)sender
{
    UINavigationController* navController = self.navigationController;
    [navController popToRootViewControllerAnimated:YES];
}



@end
