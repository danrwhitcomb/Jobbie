//
//  CustomRect.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/27/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomRect.h"

@implementation CustomRect

-(id)initWithColor:(CGColorRef)colorFill stroke:(CGColorRef)strokeFill rect:(CGRect)rect
{
    if (self = [super init]){
        self.colorFill = colorFill;
        self.strokeFill = strokeFill;
        self.rectangle = rect;
            
        return self;
        
    } else {
        return nil;
    }
}

-(void)drawCustomRect:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, self.colorFill);
    CGContextSetStrokeColorWithColor(context, self.strokeFill);
    CGContextFillRect(context, self.rectangle);
}

@end
