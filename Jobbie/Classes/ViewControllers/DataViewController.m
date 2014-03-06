//
//  DataViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/17/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//
#import "DataViewController.h"
#import "EmbedDataViewController.h"

#define SegueIdentifierFirst @"embedFirst"
#define SegueIdentifierSecond @"embedSecond"

#define MAIN_TAG 1
#define DESCRIPT_TAG 2

@interface DataViewController () <EmbedDataViewControllerDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (nonatomic, strong) EmbedDataViewController* infoController;
@property (nonatomic, strong) EmbedDataViewController* descriptController;
@property (nonatomic, strong) EmbedDataViewController* currentController;

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupGestures];
    
    self.currentSegueIdentifier = SegueIdentifierFirst;
    //[self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void) setupViews
{
    
    if(!self.view.tag){
        _infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"primCardMain"];
        _descriptController = [self.storyboard instantiateViewControllerWithIdentifier:@"primCardDescript"];
    } else {
        _infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"secCardMain"];
        _descriptController = [self.storyboard instantiateViewControllerWithIdentifier:@"secCardDescript"];
    }
    
    [self.view addSubview: _infoController.view];
    [self addChildViewController:_infoController];
    
    _infoController.view.tag = MAIN_TAG;
    _infoController.delegate = self;
    
    //Assign subivew for MainViewController
    [self.infoController didMoveToParentViewController:self];
    _currentController = _infoController;
    
    
    _descriptController.delegate = self;
}

-(void) setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToNextCard:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:panRecognizer];

}

-(void)swipeToNextCard:(UIGestureRecognizer*)gestureRecognizer
{
    [_delegate animateToNextCard: gestureRecognizer];
}


/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SegueIdentifierFirst])
    {
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
        }
        else {
            segue.destinationViewController.delegate = self;
            [self addChildViewController:segue.destinationViewController];
            ((UIViewController *)segue.destinationViewController).view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:((UIViewController *)segue.destinationViewController).view];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    else if ([segue.identifier isEqualToString:SegueIdentifierSecond])
    {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
    }
}
 */

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }];
}

- (void)swapViewControllers: (NSString*)tag;
{

    if([tag isEqual:@"embedFirst"]){
        [self addChildViewController:_infoController];
        _infoController.view.frame = self.view.bounds;
        [self moveToNewController: _infoController];
    } else {
        [self addChildViewController:_descriptController];
        _descriptController.view.frame = self.view.bounds;
        [self moveToNewController: _descriptController];

    }
    
}

- (void) moveToNewController: (EmbedDataViewController*) newController
{
    [_currentController willMoveToParentViewController:nil];
    [self transitionFromViewController:_currentController toViewController:newController duration:.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil
                            completion:^(BOOL finished) {
                                [_currentController removeFromParentViewController];
                                [newController didMoveToParentViewController:self];
                                _currentController = newController;
                            }];
}

@end
