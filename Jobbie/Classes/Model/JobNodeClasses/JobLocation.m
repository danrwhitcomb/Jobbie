//
//  JobLocation.m
//  Jobbie
//
//  Created by Dan Whitcomb on 3/30/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "JobLocation.h"

@implementation JobLocation

-(id)init
{
    return self;
}

-(NSString*) buildLocationString
{
    NSString* location = @"";
    if(![self.city isEqual:@""]){
        location = [location stringByAppendingString:self.city];
        
    }
    
    if(![self.country isEqual:@""]){
        location = [location stringByAppendingString:self.country];
    }
    
    
    return location;
}

@end
