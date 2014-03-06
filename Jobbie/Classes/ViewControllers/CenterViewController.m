//
//  CenterViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "CenterViewController.h"
#import "DataViewController.h"

#define SLIDE_TIMING .25

@interface CenterViewController ()<DataViewControllerDelegate>

@property NSMutableArray* cardControllers;
@property int currentCard;
@end

@implementation CenterViewController

/*+--------------------------------+
  |         Loading methods        |
  +--------------------------------+*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _controllerMethods = [[ControllerMethods alloc] init];
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInterfaceElements];
    _cardControllers = [[NSMutableArray alloc] init];
    [_cardControllers addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"PrimDataController"]];
    [_cardControllers addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"SecDataController"]];
    
    for(DataViewController* controller in _cardControllers){
        controller.delegate = self;
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    UINavigationController* nav = [self navigationController];
    nav.navigationBarHidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupNavigationBar];
}

/*+--------------------------------+
 |              General            |
 +--------------------------------+*/
-(UIViewController*)getHiddenCard
{
    if(_currentCard){
        return [_cardControllers objectAtIndex:0];
    } else {
        return [_cardControllers objectAtIndex:1];
    }
}

-(void) tickCurrentCard{
    _currentCard = 0 ? _currentCard : 1;
}

/*+--------------------------------+
 |         Interface Setup         |
 +--------------------------------+*/

- (void)setupInterfaceElements
{
    //Setup UIImageView attributes
    CALayer *imageLayer = [_jobImage layer];
    [imageLayer setMasksToBounds:YES];
    [imageLayer setCornerRadius:_jobImage.frame.size.width/2];
    [imageLayer setBorderWidth:4.0];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [imageLayer setBorderColor:CGColorCreate(colorSpace, (CGFloat[]){38/255.0, 185/255.0, 154/255.0, 1.0})];
}

- (void)setupNavigationBar
{
    UINavigationController* nav = self.navigationController;
    nav.navigationBarHidden = NO;
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = [UIColor colorWithRed:50/255.0 green:58/255.0 blue:69/255.0 alpha:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*+--------------------------------+
 |        Interface Animation      |
 +--------------------------------+*/
-(void) animateToNextCard: (id) sender
{
    UIViewController* newCard = [self getHiddenCard];
    UIViewController* card = [_cardControllers objectAtIndex:_currentCard];
    
    /*
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         card.view.frame = CGRectMake(310, 76, card.view.frame.size.width, card.view.frame.size.height);
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self tickCurrentCard];
                         }
                     }];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         newCard.view.frame = CGRectMake(310, 76, newCard.view.frame.size.width, newCard.view.frame.size.height);
                     } completion:^(BOOL finished) {}];
     */
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
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeftPanel) {
                [self movePanelRight];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        _showPanel = abs([sender view].center.x - _navController.view.frame.size.width/2) > _navController.view.frame.size.width/2;
        
        //Checks if the new center of the view will be greater than the center of the screen. If so, the view center is updated
        //if not, nothing happens because the user should not be able to swipe the centerView to the left
        CGPoint newPoint = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        if (newPoint.x > _navController.view.frame.size.width/2){
            [sender view].center = newPoint;
        }
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        _preVelocity = velocity;
    }
    

}



/*+--------------------------------+
 |         User Actions            |
 +--------------------------------+*/

- (IBAction)btnMovePanelRight:(id)sender
{
    UIButton* button = sender;
    
    //Initial tag is set to 1, and gets toggled after
    //each call.
    switch(button.tag){
        case 0: {
            [_delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            [_delegate movePanelRight];
            break;
        }
            
        default:
            break;
    }
}

- (IBAction)toggleScrollViewPage:(id)sender
{
    if(true){
        NSLog(@"Hit info button");
    }
        
}
@end
