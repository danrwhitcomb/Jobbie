//
//  JobNode.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/12/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobLocation.h"


@interface JobNode : NSObject

@property NSString* jobName;
@property NSString* jobCompany;
@property JobLocation* jobLocation;
@property NSString* jobDescription;
@property NSString* jobSRC;
@property NSString* jobType;
@property NSString* jobDate;

@end
