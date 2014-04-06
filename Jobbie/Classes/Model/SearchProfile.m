//
//  SearchProfile.m
//  Jobbie
//
//  Created by Dan Whitcomb on 4/3/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "SearchProfile.h"
#import "Model.h"

@implementation SearchProfile

-(id)init
{
    return self;
}

-(id)initWithName:(NSString*)name
{
    self.name = name;
    return self;
}

-(NSString*)buildURL
{
    Model* model = [Model sharedModel];
    NSString* apiKey = model.API_KEY;
    NSString* searchKey = model.SEARCH_KEY;
    NSString* baseURL = model.BASE_URL;
    apiKey = [@"api_key=" stringByAppendingString:apiKey];
    searchKey = [@"&embedded_search_key=" stringByAppendingString:searchKey];
    
    baseURL = [baseURL stringByAppendingString:apiKey];
    baseURL = [baseURL stringByAppendingString:searchKey];
    baseURL = [baseURL stringByAppendingString:@"&orig_ip=127.0.0.1"];
    NSString* keywords = [@"&keyword=" stringByAppendingString:self.jobType];
    baseURL = [baseURL stringByAppendingString:keywords];
    
    if(self.location != nil){
        NSString* location = [@"&location=" stringByAppendingString:self.location];
        baseURL = [baseURL stringByAppendingString:location];
    }
    
    if(self.company != nil){
        NSString* company = [@"&company=" stringByAppendingString:self.company];
        baseURL = [baseURL stringByAppendingString:company];
    }
    
    if(self.radius != nil){
        NSString* radius = [@"&distance=" stringByAppendingString:self.radius];
        baseURL = [baseURL stringByAppendingString:radius];
    }
    
    
    return baseURL;
}

@end
