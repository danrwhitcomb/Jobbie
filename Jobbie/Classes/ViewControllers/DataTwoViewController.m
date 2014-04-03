//
//  DataTwoViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 3/18/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "DataTwoViewController.h"
#import "EmbedDataViewController.h"
#import "EmbedDataTwoViewController.h"

#define SegueIdentifierFirst @"embedFirst"
#define SegueIdentifierSecond @"embedSecond"

#define MAIN_TAG 1
#define DESCRIPT_TAG 2


@interface DataTwoViewController () <EmbedDataTwoViewControllerDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (nonatomic, strong) EmbedDataTwoViewController* infoController;
@property (nonatomic, strong) EmbedDataTwoViewController* descriptController;
@property (nonatomic, strong) EmbedDataTwoViewController* currentController;

@property int x_location;
@property int y_location;

@end


@implementation DataTwoViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    return self;
}

/*+----------------------------+
 |      View Loaders          |
 +----------------------------+*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    [self setupGestures];
    [self setupGraphics];
    
    self.currentSegueIdentifier = SegueIdentifierFirst;
    
    _x_location = self.view.frame.origin.x;
    _y_location = self.view.frame.origin.y;
    //[self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void) setupViews
{
    
    _infoController = [self.storyboard instantiateViewControllerWithIdentifier:@"secCardMain"];
    _descriptController = [self.storyboard instantiateViewControllerWithIdentifier:@"secCardDescript"];
    
    
    [self.view addSubview: _infoController.view];
    [self addChildViewController:_infoController];
    
    _infoController.view.tag = MAIN_TAG;
    _infoController.delegate = self;
    _descriptController.delegate = self;
    
    //Assign subivew for MainViewController
    [self.infoController didMoveToParentViewController:self];
    _currentController = _infoController;
}

-(void) setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToNextCard:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:panRecognizer];
    
}

-(void) setupGraphics
{
    //Shadows
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowOffset = CGSizeMake(1.5f, 3.0f);
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

- (void) moveToNewController: (EmbedDataTwoViewController*) newController
{
    [_currentController willMoveToParentViewController:nil];
    [self transitionFromViewController:_currentController toViewController:newController duration:.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil
                            completion:^(BOOL finished) {
                                [_currentController removeFromParentViewController];
                                [newController didMoveToParentViewController:self];
                                _currentController = newController;
                            }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


@end
