//
//  Model.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/12/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "Model.h"

@implementation Model

-(id)init
{
    //Initialize arrays
    _opportunityList = [[NSMutableArray alloc] init];
    _matchList = [[NSMutableArray alloc] init];
    _xList = [[NSMutableArray alloc] init];
    
    return self;
}

-(id)matchNode:(NSObject*) node
{
    [self.opportunityList removeObject:node];
    [self.matchList addObject:node];
    
    return node;
}

-(id)xNode:(NSObject*) node
{
    [self.opportunityList removeObject:node];
    [self.xList addObject:node];
    
    return node;
}

@end
