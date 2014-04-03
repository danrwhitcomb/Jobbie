//
//  Messenger.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/13/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "Messenger.h"


@implementation Messenger

-(id)init
{    
    self.simplyHiredClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.simplyhired.com/a/jobs-api/xml-v2/"]];
    self.jobbieClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:nil]];
    
    [self.simplyHiredClient setResponseSerializer: [AFXMLParserResponseSerializer serializer]];
    [self.jobbieClient setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    return self;
}

/*
This program gets the query information that
*/
-(void)getQueryInfo
{
    
}

//- (Reachability*)checkNetworkCommunicationWithServer: (AFHTTPSessionManager*) sessionMan
//{
//    Reachability* reach = [Reachability reachabilityWithHostname:[sessionMan.baseURL absoluteString]];
//    reach.reachableBlock = ^(Reachability* reach)
//    {
//        NSLog(@"Host is reachable");
//    };
//    
//    reach.unreachableBlock = ^(Reachability* reach)
//    {
//        NSLog(@"Host is unreachable");
//    };
//    
//    [reach startNotifier];
//    return reach;
//}

- (NSURLSessionDataTask*)retrieveDataWithURL: (NSString*) relativePath andFromServer:(int) server;
{
    AFHTTPSessionManager* manager = server == 0 ? self.jobbieClient : self.simplyHiredClient;
    
    [manager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
    NSURL* requestURL = [NSURL URLWithString:relativePath relativeToURL:manager.baseURL];
    
    return [manager GET:[requestURL absoluteString]
             parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"XML: %@", responseObject);
                 [self.delegate loadResponseIntoModel:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        //[self.delegate displayError:error];
    }];
}

- (NSMutableArray*)loginToServer
{
    /*
    if(YES){
        [loginStatus insertObject:[NSNumber numberWithInt:1] atIndex:0];
        [loginStatus insertObject:loginCode atIndex:1];
        return loginStatus;
    } else {
        [loginStatus insertObject:[NSNumber numberWithInt:0] atIndex:0];
        [loginStatus insertObject:loginCode atIndex:1];
        return loginStatus;
    }
     */
    return nil;

}


//getAddress() method based on method at: 
//http://stackoverflow.com/questions/7072989/iphone-ipad-osx-how-to-get-my-ip-address-programmatically
    // Get IP Address
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}




@end
