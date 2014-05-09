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
//Jobbie Files
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Messenger.h"
#import "JobbieCommon.h"
#import "JobbieContext.h"
#import "JobbieAlert.h"
#import "JBTextField.h"
#import "User.h"

//Pods
#import <SVProgressHUD/SVProgressHUD.h>

#define LOGIN_CRED_VALIDATE_ERROR 0
#define LOGIN_CRED_MATCH_ERROR 1
#define SLIDE_TIMING .25

#define EMAIL_FIELD_KEY 0
#define PASSWORD_FIELD_KEY 1

@interface LoginViewController ()

@property CGRect baseView;
@property CGRect baseNavbar;

@property NSString* currentUser;
@property NSString* currentPassword;

@property IBOutlet JBTextField* userNameField;
@property IBOutlet JBTextField* passwordField;
@property IBOutlet UIButton* btnLogin;
@property IBOutlet UIButton* btnFBLogin;


@end

@implementation LoginViewController

#pragma mark Lifecycle

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.userNameField.delegate = self;
    self.passwordField.delegate = self;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.baseView = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    CGRect navFrame = self.navigationController.navigationBar.frame;
    self.baseNavbar = CGRectMake(navFrame.origin.x, navFrame.origin.y, navFrame.size.width, navFrame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark TextField Handlers
- (void)keyboardWillShow:(NSNotification *)notification
{
    /*
    CGRect frame = self.view.frame;
    CGRect navFrame = self.navigationController.navigationBar.frame;

    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        self.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 140, frame.size.width, frame.size.height);
        
        self.navigationController.navigationBar.frame = CGRectMake(navFrame.origin.x, navFrame.origin.y - 140, navFrame.size.width, navFrame.size.height);
    }];*/
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    /*
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        self.view.frame = self.baseView;
        
        self.navigationController.navigationBar.frame = self.baseNavbar;
    }];*/
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Respond to return button events
    //email -> password -> login
    UIResponder* nextResponder = [textField.superview viewWithTag:1];
    switch (textField.tag) {
        case 0:
            [nextResponder becomeFirstResponder];
            break;
            
        case 1:
            [self removeFocusFromTextField];
            [self onBtnSignIn:nil];
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

#pragma mark Actions

-(IBAction)onBtnSignIn:(id)sender
{
    [self setTextfieldValues];
    if([self areCredentialsValid]){
        [self doAuth];
    }
    else
    {
        [JobbieAlert show:kStrCommonAlertError message:kStrLoginAuthError];
    }
}


-(IBAction)onBtnSignup:(id)sender
{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"] animated:YES];
}

#pragma mark Server Handlers
//Actions
-(void)doAuth
{
    [SVProgressHUD showWithStatus:kStrLoginAuthProgress maskType:SVProgressHUDMaskTypeGradient];
    NSDictionary* dict = @{kStrParameterEmail : self.currentUser,
                           kStrParameterPassword : self.currentPassword,
                           kStrParameterClientKey : clientKey};
    NSString* url = [baseUrl stringByAppendingString:apiAuthenticate];
    
    [[Messenger sharedMessenger] makePOSTRequestWithString:url parameters:dict success:^(AFHTTPRequestOperation *request, id response) {
        if([self isValidResponse: response]){
            User* user = [User new];
            [user setEmailAddress:self.currentUser];
            [user setPassword:self.currentPassword];
            [[JobbieContext context] setCurrentUser: user];
            NSLog(@"Successfully Authenticated");
        }
        else {
            [JobbieAlert show:kStrCommonOops message:kStrLoginAuthError];
            NSLog(@"Failed to authenticate");
        }
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *request, NSError *error) {
        [JobbieAlert show:kStrCommonAlertError message:[error description]];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark Helpers

-(BOOL) isValidResponse:(id)response
{
    if(![response isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    
    NSDictionary* responseDict = (NSDictionary*)response;
    NSNumber* status = [NSNumber numberWithInt:[[responseDict objectForKey:@"status"] intValue]];
    
    if([status intValue] != 0){
        return NO;
    }
    
    return YES;
}

-(void)setTextfieldValues
{
    self.currentUser = ![self.userNameField.text isEqual: @""] ? self.userNameField.text : nil;
    self.currentPassword = ![self.passwordField.text  isEqual: @""] ? self.passwordField.text : nil;
}

-(BOOL)areCredentialsValid
{
    if(self.userNameField.text == nil || [self.userNameField  isEqual: @""]){
        return NO;
    }
    
    if(self.passwordField.text == nil || [self.passwordField  isEqual: @""]){
        return NO;
    }
    
    if(self.passwordField.text.length < 6){
        return NO;
    }
    
    return YES;
}

-(void) clearTextfield:(int)key
{
    if(key == EMAIL_FIELD_KEY){
        self.userNameField.text = @"";
    }
    
    if(key == PASSWORD_FIELD_KEY){
        self.passwordField.text = @"";
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
    //[self.messenger loginToServer];
    return YES;
}





@end
