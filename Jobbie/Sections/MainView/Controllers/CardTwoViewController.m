//
//  CardTwoViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 3/26/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "CardTwoViewController.h"
#import "CardTwoMainViewController.h"

@interface CardTwoViewController () <CardTwoMainViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblHidden;
@property UIViewController* currentController;
@property CardWebViewController* webViewController;

@end

@implementation CardTwoViewController

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
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.layer.borderWidth = 2;
    self.webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CardWebViewController"];
    self.mainController = [self. storyboard instantiateViewControllerWithIdentifier:@"CardOneMainViewController"];
    self.currentController = self.mainController;
    
    self.mainController.delegate = self;
    
    
    
    [self addChildViewController:self.currentController];
    
    [self.view addSubview:self.currentController.view];
    [self.view bringSubviewToFront:self.currentController.view];
    [self.currentController didMoveToParentViewController:self];
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews
{
    self.currentController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swapViewControllers: (UIViewController*) controller;
{
    
    if(controller == self.webViewController){
        [self moveToNewController: self.mainController fromCurrent:self.webViewController];
    } else {
        [self moveToNewController: self.webViewController fromCurrent:self.mainController];
        
    }
    
}

- (void) moveToNewController: (UIViewController*) newController fromCurrent:(UIViewController*) currentController
{
    [self addChildViewController:newController];
    
    newController.view.frame = self.view.bounds;                       // 2
    
    [self transitionFromViewController: currentController toViewController: newController   // 3
                              duration: 0.6 options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:^{}
                            completion:^(BOOL finished) {
                                [currentController removeFromParentViewController];                   // 5
                                [newController didMoveToParentViewController:self];
                                
                                self.currentController = newController;
                            }];}

-(void)animateNextCard: (id) sender
{
    [self.delegate animateCardSwipe:sender];
}

-(void)onBtnShuffle
{
    [self.delegate animateShuffledCard];
}

-(void)showNoResults
{
    self.mainController.view.hidden = YES;
    self.lblHidden.hidden = NO;
}

-(void)showResults
{
    self.mainController.view.hidden = NO;
    self.lblHidden.hidden = YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
