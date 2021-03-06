//
//  Model.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/12/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "Model.h"


@interface Model ()



@end


@implementation Model


+ (id)sharedModel {
    static Model *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

- (id) init {
    if (self = [super init]) {
        self.opportunityList = [[NSMutableArray alloc] init];
        self.matchList = [[NSMutableArray alloc] init];
        self.xList = [[NSMutableArray alloc] init];
        self.jobList = [[NSMutableArray alloc] init];
        
        self.searchProfiles = [[NSMutableArray alloc] init];
        
        if([self.searchProfiles count] != 0){
            self.currentProfile = [self.searchProfiles objectAtIndex:0];
        }
        
        self.API_KEY = @"27B62E8B312D95F76FF46201A2C02C61";
        self.SEARCH_KEY = @"cf287e0c63f301ca3d795780dc1771be";
        self.BASE_URL = @"http://www.linkup.com/developers/v-1/search-handler.js?";
    }
    
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

-(NSURL*)buildURL
{
    return nil;
}

#pragma -mark JSON Parsing

-(BOOL)validateData:(NSDictionary*) data
{
    NSDictionary* results = [data objectForKey:@"result_info"];
    int totalSponsored = [[results objectForKey:@"total_sponsored"] intValue];
    int totalJobs = [[results objectForKey:@"total_jobs"] intValue];
    
    if(totalJobs == 0 || totalSponsored == totalJobs){
        return NO;
    }
    
    return YES;
}

-(BOOL)loadJSONContent:(NSDictionary*) data
{
    
    if([self validateData:data]){
        NSArray* jobs = [data objectForKey:@"jobs"];
        
        JobNode* jobNode;
        for(NSDictionary* job in jobs){
            jobNode = [JobNode new];
            
            jobNode.jobName = [job objectForKey:@"job_title"];
            jobNode.jobSRC = [job objectForKey:@"job_title_link"];
            jobNode.jobCompany = [job objectForKey:@"job_company"];
            jobNode.jobTag = [job objectForKey:@"job_tag"];
            jobNode.jobDate = [job objectForKey:@"job_date_added"];
            
        
            jobNode.jobDescription = [self flattenHTML:[job objectForKey:@"job_description"]];
            
            JobLocation* location = [JobLocation new];
            location.country = [job objectForKey:@"job_country"];
            location.postalCode = [job objectForKey:@"job_zip"];
            location.city = [job objectForKey:@"job_location"];
            
            jobNode.jobLocation = location;
            [self.jobList addObject:jobNode];

        }
        
        for(JobNode* job in self.jobList){
            [self.opportunityList addObject:job];
        }
        
        return YES;
        
    } else {
        
        return NO;
        
    }
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}


-(void)resetModel
{
    [self.opportunityList removeAllObjects];
    [self.xList removeAllObjects];
    [self.matchList removeAllObjects];
    for(JobNode* job in self.jobList){[self.opportunityList addObject:job];}
    self.currentJob = [self.jobList objectAtIndex:0];
}


#pragma mark Search Profiles

-(SearchProfile*)getProfileWithName:(NSString*)name
{
    for(SearchProfile* prof in self.searchProfiles){
        if([name isEqualToString:prof.name]){
            return prof;
        }
    }
    return nil;
}

-(SearchProfile*)addProfile:(SearchProfile*)prof
{
    [self.searchProfiles addObject:prof];
    self.currentProfile = prof;
    return prof;
}

-(SearchProfile*)removeProfile:(SearchProfile*)prof
{
    [self.searchProfiles removeObject:prof];
    return prof;
}

-(SearchProfile*)removeProfileWithName:(NSString*)name
{
    SearchProfile* prof = [self getProfileWithName:name];
    if(prof != nil){
        [self.searchProfiles removeObject:prof];
        return prof;
    } else {
        return nil;
    }
}

-(SearchProfile*)updateProfileWithName:(NSString*)name andProf:(SearchProfile*) newProf
{
    SearchProfile* prof = [self getProfileWithName:name];
    int index = [self.searchProfiles indexOfObject:prof];
    [self.searchProfiles replaceObjectAtIndex:index withObject:newProf];
    return newProf;
}

@end
