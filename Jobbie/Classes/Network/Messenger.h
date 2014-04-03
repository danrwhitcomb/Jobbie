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

#import "Model.h"

@protocol MessengerDelegate <NSObject>

-(BOOL) loadResponseIntoModel: (NSXMLParser*) xmlParser;

@end

@interface Messenger : NSObject

@property AFHTTPSessionManager* simplyHiredClient;
@property AFHTTPSessionManager* jobbieClient;
@property id<MessengerDelegate> delegate;

- (NSURLSessionDataTask*)retrieveDataWithURL: (NSString*) requestURL andFromServer:(int)server;
- (NSMutableArray*)loginToServer;
@end
