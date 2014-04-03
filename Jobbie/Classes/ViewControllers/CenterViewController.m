//
//  CenterViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "CenterViewController.h"
#import "DataViewController.h"
#import "DataTwoViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

#define SLIDE_TIMING .25

@interface CenterViewController ()<DataViewControllerDelegate, DataTwoViewControllerDelegate, LeftViewControllerDelegate>

@property NSMutableArray* cardControllers;
@property int currentCard;

//Animations BOOLs
@property BOOL showingNewCard;

//CARD LOCATION GLOBALS

@property CGPoint CURRENT_CARD;
@property CGPoint SECONDARY_CARD;
@property CGPoint END_CARD;

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
        self.cardControllers = [[NSMutableArray alloc] init];
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        self.messenger = delegate.messenger;
        self.model = delegate.model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInterfaceElements];
    
    NSURL* url = [self.model buildURL];
    //[self.messenger retrieveDataWithURL:url];
    
    /*
    _cardControllers = [[NSMutableArray alloc] init];
    
    _currentCard = 0;
    DataViewController* controller;
    for(int i=0; i < [self.childViewControllers count]; i++){
        controller = [self.childViewControllers objectAtIndex:i];
        //Get the origin points from the storyboard objects for animations
        controller.delegate = self;
    }
    
    _cardControllers = self.childViewControllers;
     */
}

- (void) viewDidAppear:(BOOL)animated
{
    DataViewController* controller;
    CGPoint superOrigin;
    for(int i=0; i < [self.childViewControllers count]; i++){
        controller = [self.childViewControllers objectAtIndex:i];
        superOrigin = [[controller view] convertPoint: controller.view.frame.origin toView: [self view]];
        
        [self.cardControllers addObject:controller];
        
        if (i == 0) {
            self.CURRENT_CARD = CGPointMake(superOrigin.x, superOrigin.y);
        } else {
            self.SECONDARY_CARD = CGPointMake(superOrigin.x, superOrigin.y);

        
        }
        controller.delegate = self;
    }
    self.END_CARD = CGPointMake(-300, self.CURRENT_CARD.y);
    
    
    /*Loading prompt
    if(self.messenger.connectionFlag == nil){
     
        UIActivityIndicatorViewStyleWhiteLarge* loadingView = [[UIActivityIndicatorViewStyleWhiteLarge alloc] init];
            [self displayLoadingPrompt: loadingView];
         
        while(self.messenger.connectionFlag == nil){}
    }
    
    [self loadDataIntoView];*/
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
-(DataViewController*)getHiddenCard
{
    if(self.currentCard){
        return [self.cardControllers objectAtIndex:0];
    } else {
        return [self.cardControllers objectAtIndex:1];
    }
}

-(void) tickCurrentCard
{
    self.currentCard = 0 == self.currentCard ? 1 : 0;
}

/*+--------------------------------+
 |         Interface Setup         |
 +--------------------------------+*/

- (void)setupInterfaceElements
{
    //Setup UIImageView attributes
    CALayer *imageLayer = [self.jobImage layer];
    [imageLayer setMasksToBounds:YES];
    [imageLayer setCornerRadius:self.jobImage.frame.size.width/2];
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

-(void) loadDataIntoView
{
    //Something
}

-(UIView*) setupLoadingView
{
    /*
    CGRect rect = CGRectMake(20, 100, 50, 50);
    UIView* loadingView = [[UIView alloc] initWithFrame:rect];
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:.8 ];
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingView addSubview:indicator];
    
    UILabel* label = [UILabel]
    [loadingView ]
*/
    return nil;
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
    DataViewController* newCard = [self getHiddenCard];
    DataViewController* card = [self.cardControllers objectAtIndex:self.currentCard];
    
    [[[(UIPanGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView: card.view];
    
    /*
    if([(UIPanGestureRecognizer*) sender state] == UIGestureRecognizerStateBegan){
        
        if (velocity.x < 0){
            if(!_showingNewCard){
        
            }
        }
        
        [self.view sendSubviewToBack:card.view];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
     */
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if (self.showingNewCard) {
            [self switchCards: card newCard: newCard];

        } else {
            [self returnCardToOriginalPosition: card newCard:newCard];

        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        self.showingNewCard = card.view.frame.origin.x + (card.view.frame.size.width * (3/5.0)) < 0;
        
        //Checks if the new center of the view will be greater than the center of the screen. If so, the view center is updated
        //if not, nothing happens because the user should not be able to swipe the centerView to the left
        CGPoint newPoint = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        CGPoint newSecPoint = CGPointMake([newCard view].center.x + translatedPoint.x, [newCard view].center.y);
        
        if (newPoint.x < card.view.frame.size.width/2){
            [sender view].center = newPoint;
            [newCard view].center = newSecPoint;
            
            if(newPoint.x != 0){
                [newCard view].alpha -= translatedPoint.x * .01;
            }
            
            if(self.showingNewCard){
                [UIView animateWithDuration:SLIDE_TIMING animations:^{
                    [card view].alpha = 0.4;
                }];
            } else {
                [UIView animateWithDuration:SLIDE_TIMING animations:^{
                    [card view].alpha = 1;
                }];
            }
        }
        
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        NSLog(@"Prim ViewController: (%f, %f)", [card view].frame.origin.x, [card view].frame.origin.y);
        NSLog(@"Sec ViewController : (%f, %f)", [newCard view].frame.origin.x, [card view].frame.origin.y);
    }
    
}

-(void) returnCardToOriginalPosition: (DataViewController*)card newCard:(DataViewController*)newCard
{
    UIView *cardView = card.view;
    UIView *newCardView = newCard.view;
    CGPoint convertedCardPoint = [[self view] convertPoint:self.CURRENT_CARD toView: cardView];
    CGPoint convertedNewCardPoint = [[self view] convertPoint:self.SECONDARY_CARD toView: newCardView];
    
    
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        cardView.frame = CGRectMake(cardView.frame.origin.x + convertedCardPoint.x, convertedCardPoint.y, cardView.frame.size.width, cardView.frame.size.height);
        newCardView.frame = CGRectMake(newCardView.frame.origin.x + convertedNewCardPoint.x, convertedNewCardPoint.y, newCardView.frame.size.width, newCardView.frame.size.height);
        cardView.alpha = 1.0;
        newCardView.alpha = 0;
    } completion:nil];
    
    self.showingNewCard = NO;
}

-(void) switchCards: (DataViewController*) card newCard:(DataViewController*) newCard
{
    //Views
    UIView *cardView = card.view;
    UIView *newCardView = newCard.view;
    
    //Convert points to relative to view
    CGPoint convertedCardPoint = [[self view] convertPoint:self.END_CARD toView: cardView];
    CGPoint convertedNewCardPoint = [[self view] convertPoint:self.CURRENT_CARD toView: newCardView];
    
    //Animate
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        newCardView.frame = CGRectMake( newCardView.frame.origin.x + convertedNewCardPoint.x, convertedNewCardPoint.y, newCardView.frame.size.width, newCardView.frame.size.height);
        cardView.frame = CGRectMake(cardView.frame.origin.x + convertedCardPoint.x, convertedCardPoint.y, cardView.frame.size.width, cardView.frame.size.height);
        cardView.alpha = 0;
        newCardView.alpha = 1;
    } completion:^(BOOL finished){
        
        if(finished){
            CGPoint convertedSecCardPoint = [[self view] convertPoint:self.SECONDARY_CARD toView:cardView];
            cardView.frame = CGRectMake(cardView.frame.origin.x + convertedSecCardPoint.x, convertedSecCardPoint.y, cardView.frame.size.width, cardView.frame.size.height);
            NSLog(@"Completed switch Cards");
            NSLog(@"Prim ViewController: (%f, %f)", [card view].frame.origin.x, [card view].frame.origin.y);
            NSLog(@"Sec ViewController : (%f, %f)", [newCard view].frame.origin.x, [card view].frame.origin.y);

        }
    }];
    [self tickCurrentCard];
    self.showingNewCard = NO;
    NSLog(@"End of switch cards method");
    NSLog(@"Prim ViewController: (%f, %f)", [card view].frame.origin.x, [card view].frame.origin.y);
    NSLog(@"Sec ViewController : (%f, %f)", [newCard view].frame.origin.x, [card view].frame.origin.y);

   
}

-(void)displayLoadingPrompt: (UIView*) view
{
    
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
            [self.delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            [self.delegate movePanelRight];
            break;
        }
            
        default:
            break;
    }
}

- (IBAction)onButtonMatch:(id)sender
{
    NSLog(@"MatchButton Hit");
    [self switchCards:[self.cardControllers objectAtIndex: self.currentCard] newCard:[self getHiddenCard]];
}

-(IBAction)onButtonReject:(id)sender
{
    NSLog(@"Reject Button Hit");
    [self switchCards:[self.cardControllers objectAtIndex: self.currentCard] newCard:[self getHiddenCard]];
}

-(IBAction)onButtonProfiles:(id)sender
{
    NSLog(@"Profiles Button Hit");
    
}

@end
