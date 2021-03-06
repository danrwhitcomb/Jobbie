//
//  CardTwoMainViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 4/4/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "CardTwoMainViewController.h"
#import "Model.h"
#import "JobNode.h"

@interface CardTwoMainViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lblJobName;
@property (strong, nonatomic) IBOutlet UILabel *lblJobCompany;
@property (strong, nonatomic) IBOutlet UILabel *lblJobDate;
@property (strong, nonatomic) IBOutlet UITextView *txtJobDescription;


@end

@implementation CardTwoMainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

- (IBAction)onBtnInfo:(id)sender {
    [self.delegate swapViewControllers:self];
}

-(IBAction)onBtnShuffle:(id)sender{
    [self.delegate onBtnShuffle];
}

-(void)loadJobFromIndex:(int) ind
{
    Model* model = [Model sharedModel];
    JobNode* job = [model.opportunityList objectAtIndex: ind];
    [self.lblJobName setText:job.jobName];
    [self.lblJobCompany setText:job.jobCompany];
    [self.lblJobDate setText:job.jobDate];
    [self.txtJobDescription setText:job.jobDescription];
}


@end
