//
//  JobbieCommon.h
//  Jobbie
//
//  Created by Dan Whitcomb on 5/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobbieCommon : NSObject

//Server API
extern NSString* const clientKey;
extern NSString* const baseUrl;

extern NSString* const kStrServerError;

+(NSDictionary*)getResponseStatuses;

//API Calls
extern NSString* const apiAuthenticate;



//Login Strings
extern NSString* const kStrLoginAuthError;
extern NSString* const kStrLoginAuthProgress;



//Interface Strings
extern NSString* const kStrButtonOk;

extern NSString* const kStrCommonAlertError;
extern NSString* const kStrCommonOops;
@end
