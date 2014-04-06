//
//  AddProfileViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 4/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "AddProfileViewController.h"
#import "Model.h"
#import "SearchProfile.h"

@interface AddProfileViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation AddProfileViewController

-(void)viewDidLoad
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.textName.delegate = self;
    self.textType.delegate = self;
    self.textLocation.delegate = self;
    self.textCompany.delegate = self;
    self.textDistance.delegate = self;
    
    
    [self setTextFieldPadding:self.textName withPadding:paddingView];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    [self setTextFieldPadding:self.textType withPadding:paddingView];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    [self setTextFieldPadding:self.textLocation withPadding:paddingView];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    [self setTextFieldPadding:self.textCompany withPadding:paddingView];
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    [self setTextFieldPadding:self.textDistance withPadding:paddingView];
    
}

-(void) setTextFieldPadding:(UITextField*)text withPadding:(UIView*)view
{
    text.leftView = view;
    text.leftViewMode = UITextFieldViewModeAlways;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag)
    {
        case 0:{
            [self.textType becomeFirstResponder];
            
            break;
        }
            
        case 1:{
            [self.textLocation becomeFirstResponder];
            break;
        }

        case 2:{
            [self.textCompany becomeFirstResponder];
            break;
        }

        case 3:{
            [self.textDistance becomeFirstResponder];
            break;
        }
            
        case 4:{
            [self.textDistance resignFirstResponder];
            [self onBtnCreateProfile:self.btnCreate];
        }
            
        default:{
            break;
        }
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 2){
        [self.scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
    
    
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    return YES;
}

-(IBAction)onBtnCreateProfile:(id)sender
{
    if([self fieldsAreSafe]){
        Model* model = [Model sharedModel];
        SearchProfile* prof = [SearchProfile new];
        
        prof.name = self.textName.text;
        prof.jobType = self.textType.text;
        prof.location = self.textLocation.text;
        prof.company = self.textCompany.text;
        prof.radius = self.textDistance.text;
        
        if([self.navigationItem.title isEqual:@"Edit Profile"]){
            [model updateProfileWithName:prof.name andProf:prof];
        } else {
            [model addProfile:prof];

        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        [self showAlertWithTitle:@"Oops!" andMessage:@"Please fill in the required fields."];
    }
    
}

-(IBAction)onBtnCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) fieldsAreSafe
{
    if([self.textName.text isEqual: @""]){return NO;}
    if([self.textType.text isEqual: @""]){return NO;}
    if([self.textLocation.text isEqual:@""]){return NO;}
    
    return YES;
}

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
