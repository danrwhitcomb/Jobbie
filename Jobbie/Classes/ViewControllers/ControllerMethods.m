//
//  ControllerMethods.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/15/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "ControllerMethods.h"

@implementation ControllerMethods

-(id)init
{
    return self;
}

-(void)pushViewControllerWithIdentifier:(NSString*)controllerName
                         fromController:(UIViewController*)controller
                               animated:(BOOL)isAnimated
{
    UIViewController* newController = [controller.storyboard instantiateViewControllerWithIdentifier:controllerName];
    [controller.navigationController pushViewController:newController animated:isAnimated];
}

@end
