//
//  Messanger.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/13/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "Messanger.h"

@implementation Messanger

-(id)init
{
    return self;
}

-(void)retrieveDataFromServer
{
    if (![self initNetworkCommunication]) {
        NSLog(@"Failed to connect to server");
    }
        //[self requestJobData];
}

- (BOOL)initNetworkCommunication
{
    //Setup streams
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL,(CFStringRef)@"localhost", 80, &readStream, &writeStream);
    _inputStream = (__bridge NSInputStream *)readStream;
    _outputStream = (__bridge NSOutputStream *)writeStream;
    
    //Set stream delegates
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    //Schedule run loop
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    //Open streams
    [_inputStream open];
    [_outputStream open];
    return YES;
}




@end
