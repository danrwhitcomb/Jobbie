//
//  NavBarViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 3/27/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "NavBarViewController.h"
#import "MainViewController.h"

@interface NavBarViewController ()

@property IBOutlet UIButton* btnSettings;
@property IBOutlet UIButton* btnProfiles;
@property IBOutlet UILabel* lblHeader;
@property CGFloat CORNER_RADIUS;

@end

@implementation NavBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.CORNER_RADIUS = 5.0f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *layer = [self.btnSettings layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.CORNER_RADIUS];
    
    [self makeRoundedViewWithLayer:layer andRadius:self.CORNER_RADIUS];
    layer = [self.btnProfiles layer];
    [self makeRoundedViewWithLayer: layer andRadius:self.CORNER_RADIUS];
    
    // Do any additional setup after loading the view.
}

-(CALayer*)makeRoundedViewWithLayer:(CALayer*)layer andRadius:(CGFloat)rad
{
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:rad];
    return layer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
-(IBAction) onBtnSettings:(id)sender
{
    [self.delegate onBtnSettings:sender];
}

-(IBAction) onButtonProfiles
{
    
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
