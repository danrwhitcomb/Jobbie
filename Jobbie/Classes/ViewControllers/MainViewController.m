//
//  ViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

//Import Frameworks
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

//Import ViewControllers
#import "MainViewController.h"
#import "CenterViewController.h"
#import "LeftViewController.h"

//Quick tags for views
#define CENTER_TAG 1
#define LEFT_TAG 2

//Magic Numbers
#define CORNER_RADIUS 4
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60


@interface MainViewController () <UIGestureRecognizerDelegate,CenterViewControllerDelegate>

//Controllers
@property (nonatomic, strong) CenterViewController *centerViewController;
@property (nonatomic, strong) LeftViewController * leftViewController;

//BOOLs and Magic Numbers
@property (nonatomic, assign) BOOL showingLeftPanel;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end

@implementation MainViewController

/* +----------------------------------------------------+
   |                    VIEW LOADERS                    |
   +----------------------------------------------------+
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* setupView:
 Sets up the primary view for the application which is
 refered to by CenterView within the code
 */
- (void)setupView
{

    //Retrieve from StoryBoard and tag
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
    self.centerViewController.view.tag = CENTER_TAG;
    self.centerViewController.delegate = self;
    
    //Assign subivew for MainViewController
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:_centerViewController];
    
    [_centerViewController didMoveToParentViewController:self];
    
    [self setupGestures];
}

/* getLeftView:
 Allocates LeftView if necessary, sets shadows for the centerView
 and returns the view
 */
-(UIView *)getLeftView
{
    if(_leftViewController == nil)
    {
         //Allocate and tag
        
        self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        self.leftViewController.view.tag = LEFT_TAG;
        self.leftViewController.delegate = _centerViewController;
        
        //Assign subview for MainViewController
        [self.view addSubview:self.leftViewController.view];
        [self addChildViewController:_leftViewController];
        [_leftViewController didMoveToParentViewController:self];
        
        //Create rect holder for leftView
        _leftViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    
    self.showingLeftPanel = YES;
    [self showCenterViewWithShadow: YES withOffset:-2];
    
    return self.leftViewController.view;
}

/*resetMainView
 Removes the leftView from the main view subview list
 Sets leftViewController to nil
 Resets booleans and indicator variables concerning
 the left view and slid movement
 */
-(void)resetMainView
{
    // remove left view and reset variables, if needed
    if (_leftViewController != nil)
    {
        [self.leftViewController.view removeFromSuperview];
        self.leftViewController = nil;
        
        _centerViewController.leftButton.tag = 1;
        self.showingLeftPanel = NO;
    }
    
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
}


/* +----------------------------------------------------+
   |                 Interface Styling                  |
   +----------------------------------------------------+
 */
/* showCenterViewWithShadow
 Adds shadows to the center view to give the
 sense of depth
 */
- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset
{
    if(value)
    {
        [_centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_centerViewController.view.layer setShadowOpacity:0.8];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    else
    {
        [_centerViewController.view.layer setCornerRadius:0.0f];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    
}


/* +----------------------------------------------------+
   |                 Animation & Gestures               |
   +----------------------------------------------------+
 *//*movePanelRight
 Animation control for moving the centerView to the right
 to reveal the leftView
 */
-(void)movePanelRight
{
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{_centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     } completion:^(BOOL finished) {
                         if (finished) {
                             _centerViewController.leftButton.tag = 0;
                         }
                     }];
}

/*
 Animation control for moving the centerView to its original
 position
 */
-(void)movePanelToOriginalPosition
{
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [self resetMainView];
                         }
                     }];
}


/*
 Initializes gesture controls for the view sliders
 */
-(void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_centerViewController.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(id)sender
{
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView: self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*) sender state] == UIGestureRecognizerStateBegan){
        UIView *childView = nil;
        
        if (velocity.x > 0){
            if(!_showingLeftPanel){
                childView = [self getLeftView];
            }
        }
        
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeftPanel) {
                [self movePanelRight];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        _showPanel = abs([sender view].center.x - _centerViewController.view.frame.size.width/2) > _centerViewController.view.frame.size.width/2;
        
        // Allow dragging only in x-coordinates by only updating the x-coordinate with translation position.
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        // If you needed to check for a change in direction, you could use this code to do so.
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            // NSLog(@"same direction");
        } else {
            // NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
    }
    
}
@end
