//
//  CenterView.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/27/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "CenterView.h"
#import <Foundation/Foundation.h>

@interface CenterView()

@end

@implementation CenterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupRectValues];
    }
    return self;
}

- (void)setupRectValues
{
    float color[4] = {50/255.0, 58/255.0, 69/255.0, 1.0};
    float stroke[4] = {50/255.0, 58/255.0, 69/255.0, 1.0};
    float frameWidth = self.frame.size.width;
    
    self.headerRect = [[CustomRect alloc] initWithColor:color stroke:stroke rect:CGRectMake(0, 0, frameWidth, 70)];

}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat frameWidth = self.frame.size.width;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //headerRect
    /*CustomRectangle headerRect = {
        .colorFill = {50/255.0, 58/255.0, 69/255.0, 1.0},
        .colorStroke = {0.0,0.0,0.0,1.0},
        .rectangle = CGRectMake(0, 0, frameWidth, 70)
    };*/
    
    //mainInfoRect
    CustomRect mainInfoRect = {
        .colorFill = {255/255.0, 255/255.0, 255/255.0, 1.0},
        .colorStroke = {0.0,0.0,0.0,1.0},
        .rectangle = CGRectMake(15, 85, frameWidth - 30, 320)
    };
    
    //Stats
    
    [self drawCustomRect:headerRect context:context];
    [self drawCustomRect:mainInfoRect context: context];
}

@end
