//
//  JobbieContext.h
//  Jobbie
//
//  Created by Dan Whitcomb on 5/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface JobbieContext : NSObject

@property User* currentUser;
@property BOOL isFirstLaunch;

+(id)context;

@end
