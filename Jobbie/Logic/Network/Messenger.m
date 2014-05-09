//
//  Messenger.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/13/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "Messenger.h"


@interface Messenger ()

@property AFHTTPRequestOperationManager* manager;

@end

@implementation Messenger

#pragma mark Singleton Methods

+ (id)sharedMessenger {
    static Messenger *sharedMessenger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMessenger = [[self alloc] init];
    });
    return sharedMessenger;
}

- (id) init {
    if (self = [super init]) {
        self.manager = [AFHTTPRequestOperationManager manager];
        [self setJSONResponseSerializer];
        [self.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    }
    return self;
}

-(void)setJSONResponseSerializer
{
    [self.manager setResponseSerializer: [AFJSONResponseSerializer serializer]];
}

-(void)setXMLResponseSerializer
{
    [self.manager setResponseSerializer: [AFXMLParserResponseSerializer serializer]];
}


- (AFHTTPRequestOperation*)makeGETRequestWithString:(NSString*) url parameters: (NSDictionary*) param success: (void (^)(AFHTTPRequestOperation* request, id response)) success failure: (void(^)(AFHTTPRequestOperation* request, NSError* error)) failure
{
    return [self.manager GET:url parameters:param success:success failure:failure];
}

- (AFHTTPRequestOperation*)makePOSTRequestWithString:(NSString*) url parameters: (NSDictionary*) param success:(void ( ^ ) ( AFHTTPRequestOperation *operation , id responseObject ))success failure:(void ( ^ ) ( AFHTTPRequestOperation *operation , NSError *error ))failure
{
    return [self.manager POST:url parameters:param success:success failure:failure];
}

- (AFHTTPRequestOperation*)makePOSTRequestWithString:(NSString *)url constructingDict:(NSDictionary*) formData success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData * data = [NSMutableData data];
    [data appendData:[NSJSONSerialization dataWithJSONObject:formData options:0 error:nil]];
    [request setHTTPBody:data];
    
    AFHTTPRequestOperation* operation = [self.manager HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [operation start];
    
    return operation;
}

@end