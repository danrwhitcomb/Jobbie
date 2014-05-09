//
//  SignUpViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 5/9/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "SignUpViewController.h"
#import "JBTextField.h"

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet JBTextField *fieldFirstName;
@property (strong, nonatomic) IBOutlet JBTextField *fieldLastName;
@property (strong, nonatomic) IBOutlet JBTextField *fieldEmail;
@property (strong, nonatomic) IBOutlet JBTextField *fieldPassword;
@property (strong, nonatomic) IBOutlet JBTextField *fieldConfirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnCreateAccount;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@end

@implementation SignUpViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
