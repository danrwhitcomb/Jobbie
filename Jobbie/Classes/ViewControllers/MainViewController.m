//
//  ViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

//Import Frameworks


//Import My files
#import "MainViewController.h"


//QuickTagsForViews
#define CARD_ONE_TAG 1
#define CARD_TWO_TAG 2

//Magic Numbers
#define CORNER_RADIUS 4
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60
#define NAV_BAR_HEIGHT 80

//Move down values for shuffled controller
#define MOVE_DOWN_X 3
#define MOVE_DOWN_Y 3

//Card border
#define TOP_EDGE_OFFSET 90
#define EDGE_OFFSET 10


@interface MainViewController () <UIGestureRecognizerDelegate, CardOneViewControllerDelegate, CardTwoViewControllerDelegate, NavBarViewControllerDelegate>

//Controllers
@property (nonatomic, strong) CardOneViewController *cardOneController;
@property (nonatomic, strong) CardTwoViewController *cardTwoController;
@property (nonatomic, strong) NavBarViewController  *navBarController;
@property (nonatomic, strong) UINavigationController* navController;
@property (nonatomic, strong) SettingsViewController* settingsController;
@property NSInteger currentCard;
@property NSMutableArray* cardControllers;

//BOOLs and Magic Numbers
@property (nonatomic, assign) CGPoint preVelocity;

//Locations of cards
@property CGPoint waitingPoint;
@property CGPoint viewingPoint;
@property CGPoint rejectPoint;
@property CGPoint matchPoint;

//Animation Flags
@property BOOL showingNewCard;

//Buttons
@property IBOutlet UIButton* btnShuffle;

@property AFNetworkActivityIndicatorManager* networkActIndicator;

@property ControllerMethods* controllerMethods;
@property AppDelegate* appDelegate;

@property IBOutlet UIActivityIndicatorView* actIndicator;

@end

@implementation MainViewController

/* +----------------------------------------------------+
   |                    VIEW LOADERS                    |
   +----------------------------------------------------+
 */

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.controllerMethods = [[ControllerMethods alloc] init];
        self.appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    _controllerMethods = [[ControllerMethods alloc] init];
    
    self.waitingPoint = CGPointMake(EDGE_OFFSET - self.view.frame.size.width, NAV_BAR_HEIGHT + EDGE_OFFSET);
    self.viewingPoint = CGPointMake(EDGE_OFFSET, NAV_BAR_HEIGHT + EDGE_OFFSET);
    self.matchPoint   = CGPointMake(EDGE_OFFSET, 0 - self.view.frame.size.height + EDGE_OFFSET);
    self.rejectPoint  = CGPointMake(EDGE_OFFSET, self.view.frame.size.height + EDGE_OFFSET);
    [self.view bringSubviewToFront:self.btnShuffle];
    self.currentCard = 0;
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
    
    self.cardOneController = [self.storyboard instantiateViewControllerWithIdentifier:@"CardOneViewController"];
    self.cardTwoController = [self.storyboard instantiateViewControllerWithIdentifier:@"CardTwoViewController"];
    self.navBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavBarViewController"];
    
    self.cardOneController.delegate = self;
    self.cardTwoController.delegate = self;
    self.navBarController.delegate = self;
    
    self.cardControllers = [[NSMutableArray alloc] initWithObjects: self.cardOneController, self.cardTwoController, nil];
    [self setupSubviewsUsingArray: self.cardControllers];
    [self setupGesturesUsingArray: self.cardControllers];
    [self.view addSubview:self.navBarController.view];
}

-(void) setupSubviewsUsingArray: (NSMutableArray*) viewControllers;
{
    for(UIViewController* controller in viewControllers){
        [self.view addSubview:controller.view];
    }
    
    
    
    [self.view bringSubviewToFront:self.cardOneController.view];

    
    //SetupviewLocations
}

-(void) viewWillAppear:(BOOL)animated
{
    self.cardOneController.view.frame = CGRectMake(self.viewingPoint.x, self.viewingPoint.y, self.view.frame.size.width - (EDGE_OFFSET * 2), self.view.frame.size.height - (EDGE_OFFSET + TOP_EDGE_OFFSET));
    self.cardTwoController.view.frame = CGRectMake(self.waitingPoint.x, self.waitingPoint.y, self.view.frame.size.width - (EDGE_OFFSET * 2), self.view.frame.size.height - (EDGE_OFFSET + TOP_EDGE_OFFSET));
    
    
    self.navBarController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, NAV_BAR_HEIGHT);
}


-(void) setupGesturesUsingArray:(NSMutableArray*)controllers
{
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.cardOneController action:@selector(animateNextCard:)];
    [self.cardOneController.view addGestureRecognizer:panGesture];
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.cardTwoController action:@selector(animateNextCard:)];
    [self.cardTwoController.view addGestureRecognizer:panGesture];
}

-(UIViewController*)getHiddenCard
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
        [_navController.view.layer setCornerRadius:CORNER_RADIUS];
        [_navController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_navController.view.layer setShadowOpacity:0.8];
        [_navController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    else
    {
        [_navController.view.layer setCornerRadius:0.0f];
        [_navController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    
}

/* +----------------------------------------------------+
   |                       Actions                      |
   +----------------------------------------------------+
*/

-(void)onBtnSettings:(id) sender
{
    if(self.settingsController == nil){
        self.settingsController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    }

    [self.view addSubview:self.settingsController.view];
    [self.view bringSubviewToFront:self.settingsController.view];
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        self.settingsController.view.alpha = 1;
    }];
}

-(void)onBtnProfiles:(id)sender
{
    
}

/* +----------------------------------------------------+
   |                 Animation & Gestures               |
   +----------------------------------------------------+
 *//*movePanelRight
 Animation control for moving the centerView to the right
 to reveal the leftView
 */
-(void) animateCardSwipe:(id)sender
{
    UIViewController* viewingCard;
    UIViewController* waitingCard;
    if([((UIViewController*)sender).view isEqual: self.cardOneController.view]){
        viewingCard = self.cardOneController;
        waitingCard = self.cardTwoController;
    } else {
        viewingCard = self.cardTwoController;
        waitingCard = self.cardOneController;
    }
    
    [[[(UIPanGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView: viewingCard.view];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if (self.showingNewCard) {
            if(viewingCard.view.frame.origin.y < (0 - (self.view.frame.size.height * (3/5.0)))){
                [self animateMatchedCard: viewingCard withWaitingCard:waitingCard];
            } else {
                [self animateRejectedCard: viewingCard withWaitingCard:waitingCard];
            }
        } else {
            [self returnCardToOriginalPosition:sender];
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        self.showingNewCard = viewingCard.view.frame.origin.y < (0 - (self.view.frame.size.height * (3/5.0))) || viewingCard.view.frame.origin.y > viewingCard.view.frame.size.height * (3/5.0);
        //Checks if the new center of the view will be greater than the center of the screen. If so, the view center is updated
        //if not, nothing happens because the user should not be able to swipe the centerView to the left
        CGPoint newPoint = CGPointMake([sender view].center.x, [sender view].center.y + translatedPoint.y);
        
        [sender view].center = newPoint;
            
        if(self.showingNewCard){
            [UIView animateWithDuration:SLIDE_TIMING animations:^{
                viewingCard.view.alpha = 0.4;
            }];
        } else {
            [UIView animateWithDuration:SLIDE_TIMING animations:^{
                viewingCard.view.alpha = 1;
            }];
        }
    
        
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
    }
    
}

-(void) returnCardToOriginalPosition: (UIViewController*)card
{
    UIView* cardView = [card view];
    
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        cardView.frame = CGRectMake(self.viewingPoint.x, self.viewingPoint.y, cardView.frame.size.width, cardView.frame.size.height);
        cardView.alpha = 1.0;
    } completion:nil];
    self.showingNewCard = NO;
}


-(void)animateMatchedCard: (UIViewController*) matchedCard withWaitingCard:(UIViewController*) waitingCard
{
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        matchedCard.view.frame = CGRectMake(self.matchPoint.x, self.matchPoint.y, matchedCard.view.frame.size.width, matchedCard.view.frame.size.height);
        
    } completion:^(BOOL complete){
        if(complete){[self animateCardToViewing:waitingCard andCardToWaiting:matchedCard];}
    }];
}

-(void)animateRejectedCard: (UIViewController*) rejectedCard withWaitingCard:(UIViewController*)waitingCard
{
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        rejectedCard.view.frame = CGRectMake(self.rejectPoint.x, self.rejectPoint.y, rejectedCard.view.frame.size.width, rejectedCard.view.frame.size.height);
        
    } completion:^(BOOL complete){
        if(complete){[self animateCardToViewing:waitingCard andCardToWaiting:rejectedCard];}
    }];

}

-(IBAction)animateShuffledCard:(id)sender{
    
    UIViewController* shuffledCard = [self.cardControllers objectAtIndex:self.currentCard];
    UIViewController* waitingCard  = [self getHiddenCard];
    
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        shuffledCard.view.frame = CGRectMake(shuffledCard.view.frame.origin.x + MOVE_DOWN_X, shuffledCard.view.frame.origin.y + MOVE_DOWN_Y, shuffledCard.view.frame.size.width, shuffledCard.view.frame.size.height);
    } completion:^(BOOL complete){
        if(complete){[self animateCardToViewing:waitingCard andCardToWaiting:shuffledCard];}
    }];
}

-(void)animateCardToViewing:(UIViewController*) card andCardToWaiting:(UIViewController*)newWaiting
{
    [UIView animateWithDuration:SLIDE_TIMING animations:^{
        card.view.frame = CGRectMake(self.viewingPoint.x, self.viewingPoint.y, card.view.frame.size.width, card.view.frame.size.height);
    } completion:^(BOOL complete){
        newWaiting.view.frame = CGRectMake(self.waitingPoint.x, self.waitingPoint.y, newWaiting.view.frame.size.width, newWaiting.view.frame.size.height);
        newWaiting.view.alpha = 1;
        [self tickCurrentCard];
    }];
   
}


@end
