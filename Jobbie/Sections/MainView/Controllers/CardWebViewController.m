//
//  CardWebViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 4/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "CardWebViewController.h"
#import "CardOneViewController.h"
#import "CardTwoViewController.h"
#import "Model.h"
#import "JobNode.h"

@interface CardWebViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CardWebViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    CGRect parentFrame = self.parentViewController.view.frame;
    self.view.frame = CGRectMake(0, 0, parentFrame.size.width , parentFrame.size.height);
    
    Model* model = [Model sharedModel];
    JobNode* jobNode = [model currentJob];
    
    [self.webView loadHTMLString:jobNode.jobName baseURL:[NSURL URLWithString:jobNode.jobSRC]];
}

- (IBAction)onBtnBack:(id)sender {
    
    if([self.parentViewController isMemberOfClass:[CardOneViewController class]]){
        CardOneViewController* parentController = (CardOneViewController*)self.parentViewController;
        [parentController swapViewControllers: self];
    } else {
        CardTwoViewController* parentController = (CardTwoViewController*)self.parentViewController;
        [parentController swapViewControllers: self];
    }
}

-(IBAction)btnBack:(id)sender
{
    [self.webView goBack];
}

-(IBAction)btnForward:(id)sender
{
    [self.webView goForward];
}


@end
