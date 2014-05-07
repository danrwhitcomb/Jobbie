//
//  JobbieAlert.h
//  Jobbie
//
//  Created by Dan Whitcomb on 5/6/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SIAlertView/SIAlertView.h>

@class JobbieAlert;

typedef void (^JobbieAlertBlock)(JobbieAlert *alertView, NSInteger buttonIndex);

@interface JobbieAlert : UIAlertView

+ (void) show:(NSString*)title message:(NSString*)message buttons:(NSArray *)buttons block:(JobbieAlertBlock)block tag:(int)tag style:(UIAlertViewStyle)style;

+ (void) show:(NSString*)title message:(NSString*)message buttons:(NSArray *)buttons block:(JobbieAlertBlock)block tag:(int)tag;

+ (void) show:(NSString*)title message:(NSString*)message buttons:(NSArray *)buttons block:(JobbieAlertBlock)block;

+ (void) show:(NSString*)title message:(NSString*)message;
+ (void) showError:(NSString*)message;

@end
