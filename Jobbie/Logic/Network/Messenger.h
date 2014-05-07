//
//  Messenger.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/13/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "stdlib.h"
#import "string.h"
#import "stdio.h"

#import <AFNetworking/AFNetworking.h>

@interface Messenger : NSObject

+(id)sharedMessenger;
-(void)setJSONResponseSerializer;
-(void)setXMLResponseSerializer;
-(void)dealloc;
- (AFHTTPRequestOperation*)makeGETRequestWithString:(NSString*) url parameters: (NSDictionary*) param success: (void (^)(AFHTTPRequestOperation* request, id response)) success failure: (void(^)(AFHTTPRequestOperation* request, NSError* error)) failure;

- (AFHTTPRequestOperation*)makePOSTRequestWithString:(NSString*) url parameters: (NSDictionary*) param success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure;

@end
