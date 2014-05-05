//
//  JobLocation.h
//  Jobbie
//
//  Created by Dan Whitcomb on 3/30/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobLocation : UIViewController

@property NSString* city;
@property NSString* postalCode;
@property NSString* country;

-(NSString*) buildLocationString;

@end
