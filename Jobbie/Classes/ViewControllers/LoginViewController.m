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
#define LOGIN_CRED_VALIDATE_ERROR 0
#define LOGIN_CRED_MATCH_ERROR 1

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _controllerMethods = [[ControllerMethods alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.restorationIdentifier  isEqual: @"LoginViewController"]){
        
        //Rounded Button rects
        CALayer *btnLayer = [_loginBtn layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
    
        //Make scroll view bigger so it can be scrolled up when the
        //text fields are selected
        [_scrollView setContentOffset:CGPointZero];
        NSLog(@"Content Offset: %f, %f", _scrollView.contentOffset.x,  _scrollView.contentOffset.y);

    
        //Set the VC as delegate so it can implement UITextField methods
        [_userNameField setDelegate:self];
        [_passwordField setDelegate:self];
    } else if([self.restorationIdentifier isEqual:@"NewAccountViewController"]){
        
    } else { //ForgotPasswordViewController
        
    }
    
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
    [_scrollView setContentOffset:CGPointMake(0, 60)  animated:YES];
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
    NSLog(@"Content Offset: %f, %f", _scrollView.contentOffset.x,  _scrollView.contentOffset.y);
    [_scrollView setContentOffset:CGPointZero animated:YES];
    [_userNameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    NSLog(@"Content Offset: %f, %f", _scrollView.contentOffset.x,  _scrollView.contentOffset.y);

}


//Actions
-(void)loginToApp
{
    //Wipe error
    _loginErrorLbl.text = @"";
    
    //Get text field values
    NSString* username = _userNameField.text;
    NSString* passwowrd = _passwordField.text;
    
    //Match login credentials with database
    if (![self matchLoginCredentialsWithUsername:username andPassword:passwowrd]){
        [self displayLoginError];
    } else {
        [_controllerMethods pushViewControllerWithIdentifier:@"MainViewController" fromController:self animated:YES];
    }
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
    return FALSE;
}

-(void)displayLoginError
{
    [self removeFocusFromTextField];
    _loginErrorLbl.text = @"Your email/password combination does not match out records";
}

//IBActions
-(IBAction)loginBtnPress:(id)sender
{
    [self loginToApp];
}

/*
 This is ugly and needs to be streamlined. Will have to do for now.
 */
-(IBAction)loginBtnFromCreateAccount:(id)sender
{
    UINavigationController* navController = self.navigationController;
    UIViewController* newView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [navController pushViewController:newView animated:YES];
}

-(IBAction)newAccountBtnPress:(id)sender
{
    [_controllerMethods pushViewControllerWithIdentifier:@"NewAccountViewController" fromController:self animated:YES];
}


@end
