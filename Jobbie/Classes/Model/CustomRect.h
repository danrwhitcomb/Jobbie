//
//  CustomRect.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/27/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomRect : NSObject

@property CGColorRef colorFill;
@property CGColorRef strokeFill;
@property CGRect rectangle;

-(id)initWithColor:(CGColorRef)colorFill stroke:(CGColorRef)strokeFill rect:(CGRect)rect;

-(void)drawCustomRect:(CGContextRef)context;

@end
