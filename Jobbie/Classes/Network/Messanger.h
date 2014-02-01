//
//  Messanger.h
//  Jobbie
//
//  Created by Dan Whitcomb on 12/13/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Messanger : NSObject <NSStreamDelegate>

@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

@end
