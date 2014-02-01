//
//  DataViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/17/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

//IBActions
-(IBAction)returnFromModalPush:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
