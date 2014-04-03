//
//  Model.m
//  Jobbie
//
//  Created by Dan Whitcomb on 12/12/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "Model.h"

@interface Model ()

@property NSMutableArray* opportunityList;
@property NSMutableArray* matchList;
@property NSMutableArray* xList;
@property NSMutableArray* jobList;

@property JobNode* currentJob;
@property NSString* currentValue;

@property NSMutableArray* userProfiles;

@end


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

-(NSURL*)buildURL
{
    return [NSURL URLWithString:@"http://http://api.simplyhired.com/a/jobs-api/xml-v2/q-entry-level+%26+internship?pshid=56324&ssty=2&cflg=r&jbd=Jobbie.jobamatic.com&clip=24.13.241.216"];
}

#pragma -mark XML Parsing

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"r"]){
        JobNode* jobNode = [JobNode new];
        [self.jobList addObject: jobNode];
        self.currentJob = jobNode;
     
    
    } else if ([elementName isEqualToString:@"loc"]){
        JobLocation* location = [JobLocation new];
        [location setCity: [attributeDict objectForKey:@"cty"]];
        [location setStateAbrv: [attributeDict objectForKey:@"st"]];
        [location setPostalCode: [attributeDict objectForKey:@"postal"]];
        [location setCountry: [attributeDict objectForKey:@"county"]];
        [location setRegion: [attributeDict objectForKey:@"region"]];
        [location setCountry: [attributeDict objectForKey:@"country"]];
        [self.currentJob setJobLocation: location];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.currentValue = string;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"jt"]){
        [self.currentJob setJobName: self.currentValue];
    } else if([elementName isEqualToString:@"cn"]){
        [self.currentJob setJobCompany:self.currentValue];
    } else if([elementName isEqualToString:@"src"]){
        [self.currentJob setJobSRC:self.currentValue];
    } else if([elementName isEqualToString:@"ty"]){
        [self.currentJob setJobType:self.currentValue];
    } else if([elementName isEqualToString:@"loc"]){
        [self.currentJob setJobSRC:self.currentValue];
    } else if([elementName isEqualToString:@"dp"]){
        [self.currentJob setJobDate:self.currentValue];
    } else if([elementName isEqualToString:@"e"]){
        [self.currentJob setJobDescription:self.currentValue];
    }

}

@end
