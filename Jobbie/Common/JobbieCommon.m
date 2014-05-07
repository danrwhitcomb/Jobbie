//
//  JobbieCommon.m
//  Jobbie
//
//  Created by Dan Whitcomb on 5/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "JobbieCommon.h"

@implementation JobbieCommon

#pragma mark Server API
NSString* const clientKey = @"3CJS?#pl1FhX*Yq:)(2qy*3M78@8Y7";
NSString* const baseUrl = @"http://localhost:5000";

NSString* const kStrServerError = @"Servor Error";

static NSDictionary* dic = nil;

+ (NSDictionary*)getResponseStatuses {
    
    if (dic == nil){
        dic = @{[NSNumber numberWithInt:0]:@"Operation completed successfully",
                [NSNumber numberWithInt:1]:@"Internal Server Error",
                [NSNumber numberWithInt:2]:@"The requested method is not supported",
                [NSNumber numberWithInt:3]:@"The provided arguments are invalid",
                [NSNumber numberWithInt:4]:@"Invalid key. You are unauthorized to use this service",
                [NSNumber numberWithInt:5]:@"Invalid credentials",
                [NSNumber numberWithInt:6]:@"The user cannot be found"
                };
    }
    
    return dic;
}

//API Calls
NSString* const apiAuthenticate = @"/api/accounts/authenticate";


#pragma mark Account Strings
NSString* const kStrLoginAuthError = @"Authentication Error";
NSString* const kStrLoginAuthProgress = @"Authorizing...";

#pragma mark Interface Strings
NSString* const kStrButtonOk = @"Okay";

NSString* const kStrCommonAlertError = @"Error";
NSString* const kStrCommonOops = @"Oops!";

@end
