//
//  JobbieContext.m
//  Jobbie
//
//  Created by Dan Whitcomb on 5/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "JobbieContext.h"

@implementation JobbieContext

+ (JobbieContext*) context
{
    static id _sharedObject = nil;
    static dispatch_once_t once = 0;
    
    dispatch_once(&once, ^(void)
                  {
                      _sharedObject = [[self alloc] init];
                  });
    return _sharedObject;
}

- (id) init
{
    if( nil != (self = [super init]) )
    {
        self.isFirstLaunch = YES;
    }
    return self;
}




@end
