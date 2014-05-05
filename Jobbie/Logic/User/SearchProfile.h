//
//  SearchProfile.h
//  Jobbie
//
//  Created by Dan Whitcomb on 4/3/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchProfile : NSObject

@property NSString* name;
@property NSString* location;
@property NSString* jobType;
@property NSString* company;
@property NSString* radius;

@property NSMutableArray* opportunityList;
@property NSMutableArray* matchList;
@property NSMutableArray* xList;
@property NSMutableArray* jobList;

-(NSString*) buildURL;

@end
