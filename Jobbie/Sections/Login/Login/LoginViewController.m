//
//  LoginViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/15/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//
/*
 This ViewController file handles the views for the login page,
 create account page, and the lost password page
 
 Current login credential requirements
 username: valid dartmouth email address
 password: between 6 and 18 characters in length
 
 */

#import "LoginViewController.h"
#import "AppDelegate.h"
#define LOGIN_CRED_VALIDATE_ERROR 0
#define LOGIN_CRED_MATCH_ERROR 1

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup tap responder to remove the keyboard to get out of
    //the textField editor
    UITapGestureRecognizer *outsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField)];
    
    [self.view addGestureRecognizer:outsideTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Textfield handlers
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //Scroll the view up so the text fields can be seen
    //with the keyboard
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Respond to return button events
    //email -> password -> login
    UIResponder* nextResponder = [textField.superview viewWithTag:1];
    UIViewController* mainViewController = nil;
    switch (textField.tag) {
        case 0:
            [nextResponder becomeFirstResponder];
            break;
            
        case 1:
            [self loginToApp];
            break;
            
        default:
            break;
    }
    
    return YES;
}



-(void)removeFocusFromTextField
{
    [_userNameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}


//Actions
-(void)loginToApp
{
    
    //Get text field values
    NSString* username = _userNameField.text;
    NSString* passwowrd = _passwordField.text;
}

/*
 This is hard coded. Would like to streamline eventually.
 */
-(BOOL)validateLoginCredentialsWithUsername: (NSString*)username andPassword:(NSString*)password
{
    //Check password length criteria
    if ([password length] < 6 || [password length] > 18){
        return FALSE;
    }
    
    //Check if valid email address
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}" options:NSRegularExpressionCaseInsensitive error:&error];
    if ([regex numberOfMatchesInString:username options:0 range:NSMakeRange(0, [username length])] != 1){
        return FALSE;
    }
    
    return TRUE;
}

-(BOOL)matchLoginCredentialsWithUsername:(NSString*)username andPassword:(NSString*)password
{
    //[self.messenger loginToServer];
    return YES;
}

-(void)displayLoginError
{
    [self removeFocusFromTextField];
}

//IBActions
-(IBAction)loginBtnPress:(id)sender
{
    [self loginToApp];
}


@end
