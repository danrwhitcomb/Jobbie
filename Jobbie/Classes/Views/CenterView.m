//
//  CenterView.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/27/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "CenterView.h"
#import <Foundation/Foundation.h>

//Rect dimensions and positions
//The init Method of the view takes into account
//the different device, and assigns the correct values

//Dimensions for 4-inch screen
#define STAT_RECT_HEIGHT 60

@interface CenterView()

@end

@implementation CenterView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupRectValues];
    }
    return self;
}

- (void) awakeFromNib
{
    [self checkUIObjectLocations];
}

- (void)setupRectValues
{

    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    CGFloat baseObjectOffset = frameHeight / 40;
    CGFloat headerRectOffset = frameHeight / 7.6;
    CGFloat mainInfoRectWidth = frameWidth - (frameHeight / 20);
    CGFloat mainInfoRectYOffset = baseObjectOffset + headerRectOffset;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //Rect setups
    self.mainInfoRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){1.0, 1.0, 1.0, 1.0})
                                                   stroke: CGColorCreate(colorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0})
                                                     rect: CGRectMake(baseObjectOffset, mainInfoRectYOffset, frameWidth - (baseObjectOffset * 2), frameHeight / 1.54)];

    
    //Stat Rects
    
    CGFloat statRectYOffset = mainInfoRectYOffset + (frameHeight / 5);
    self.statsLeftRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){20/255.0, 185/255.0, 214/255.0, 1.0})
                                                    stroke: CGColorCreate(colorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0})
                                                      rect: CGRectMake(baseObjectOffset, statRectYOffset, mainInfoRectWidth/3.0, STAT_RECT_HEIGHT)];

    
    self.statsMidRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){240/255.0, 106/255.0, 81/255.0, 1.0})
                                                   stroke: CGColorCreate(colorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0})
                                                     rect: CGRectMake(baseObjectOffset + mainInfoRectWidth/3.0, statRectYOffset, mainInfoRectWidth/3.0, STAT_RECT_HEIGHT)];

    
    self.statsRightRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){38/255.0, 185/255.0, 154/255.0, 1.0})
                                                     stroke: CGColorCreate(colorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0})
                                                       rect: CGRectMake(baseObjectOffset + (2*mainInfoRectWidth)/3, statRectYOffset, mainInfoRectWidth/3.0, STAT_RECT_HEIGHT)];

    
    self.descriptRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){234/255.0, 237/255.0, 241/255.0, 1.0})
                                                   stroke: CGColorCreate(colorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0})
                                                     rect: CGRectMake(baseObjectOffset * 2, statRectYOffset + baseObjectOffset + STAT_RECT_HEIGHT, frameWidth - (baseObjectOffset * 4), frameHeight / 4)];
    
}

- (void)checkUIObjectLocations
{
    /* Deprecated code for handling change in vertical view size
    if(self.frame.size.height != 568){
        
        //Header elements
        NSMutableArray *elementArray = [[NSMutableArray alloc] initWithObjects: self.drawerButton, self.headerLabel, nil];
        [self offsetObjectCenters:elementArray byXValue: 0 byYValue: -10];
        
        //Title and picture
        elementArray = [[NSMutableArray alloc] initWithObjects: self.jobImageView, self.companyNameLabel, self.companyLocationLabel, self.infoButton, nil];
        [self offsetObjectCenters:elementArray byXValue: 0 byYValue: -18];
        [self.infoButton setCenter:CGPointMake(self.infoButton.center.x + 7, self.infoButton.center.y)];
        
        //Stat Rects
        elementArray = [[NSMutableArray alloc] initWithObjects: self.matchStatLabel, self.xStatLabel, self.ratingStatLabel, nil];
        [self offsetObjectCenters:elementArray byXValue: 0 byYValue: -28];
        
        //Match and X buttons
        elementArray = [[NSMutableArray alloc] initWithObjects: self.xButton, self.matchButton, nil];
        [self offsetObjectCenters:elementArray byXValue: 0 byYValue:-80];
        
        //Descript label
        [self.descriptLabel setCenter:CGPointMake(self.descriptLabel.center.x, self.descriptLabel.center.y - 40)];
        
    }
     */
}

- (void)offsetObjectCenters:(NSMutableArray*)array byXValue:(CGFloat) xValue byYValue:(CGFloat) yValue
{
    for (UIView *object in array) {
        [object setCenter:CGPointMake(object.center.x + xValue, object.center.y + yValue)];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //headerRect
    [self.headerRect drawCustomRect:context];
    [self.mainInfoRect drawCustomRect:context];
    [self.statsLeftRect drawCustomRect:context];
    [self.statsMidRect drawCustomRect:context];
    [self.statsRightRect drawCustomRect:context];
    [self.descriptRect drawCustomRect:context];
}

@end
