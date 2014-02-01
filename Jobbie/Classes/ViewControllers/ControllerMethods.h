//
//  ControllerMethods.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/15/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ControllerMethods : NSObject

-(void)pushViewControllerWithIdentifier:(NSString*)controllerName
                         fromController:(UIViewController*)controller
                               animated:(BOOL)isAnimated;


@end
