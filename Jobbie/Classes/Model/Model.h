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

@end
