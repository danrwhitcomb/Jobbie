//
//  DescriptionView.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/19/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "DescriptionView.h"

@implementation DescriptionView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupRectValues];
    }
    return self;
}

-(void)setupRectValues
{
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    CGFloat baseObjectOffset = frameHeight / 40;
    CGFloat headerRectOffset = frameHeight / 7.6;
    CGFloat mainInfoRectWidth = frameWidth - (frameHeight / 20);
    CGFloat mainInfoRectYOffset = baseObjectOffset + headerRectOffset;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //Rect setups
    self.headerRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){50/255.0, 58/255.0, 69/255.0, 1.0})
                                                 stroke: CGColorCreate(colorSpace, (CGFloat[]){0.0, 0.0, 0.0, 1.0})
                                                   rect: CGRectMake(0, 0, frameWidth, headerRectOffset)];
    
    self.infoRect = [[CustomRect alloc] initWithColor: CGColorCreate(colorSpace, (CGFloat[]){1, 1, 1, 1})
                                               stroke: CGColorCreate(colorSpace, (CGFloat[]){0,0,0,1})
                                                 rect: CGRectMake(baseObjectOffset, mainInfoRectYOffset, mainInfoRectWidth, frameHeight - headerRectOffset - baseObjectOffset * 2)];
     
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_headerRect drawCustomRect: context];
    [_infoRect drawCustomRect: context];
}


@end
