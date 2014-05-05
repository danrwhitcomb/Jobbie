//
//  Model.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/12/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobNode.h"
#import "SearchProfile.h"

@interface Model : NSObject <NSXMLParserDelegate>

-(NSURL*)buildURL;
+(Model*)sharedModel;

@property NSMutableArray* opportunityList;
@property NSMutableArray* matchList;
@property NSMutableArray* xList;
@property NSMutableArray* jobList;

@property JobNode* currentJob;
@property NSString* currentValue;

@property NSMutableArray* searchProfiles;
@property SearchProfile* currentProfile;

@property NSString* API_KEY;
@property NSString* SEARCH_KEY;
@property NSString* BASE_URL;

-(BOOL)loadJSONContent:(NSDictionary*) data;

-(SearchProfile*)getProfileWithName:(NSString*)name;

-(SearchProfile*)addProfile:(SearchProfile*)prof;

-(SearchProfile*)removeProfile:(SearchProfile*)prof;

-(SearchProfile*)removeProfileWithName:(NSString*)name;

-(SearchProfile*)updateProfileWithName:(NSString*)name andProf:(SearchProfile*) newProf;

@end
