//
//  JobbieAlert.m
//  Jobbie
//
//  Created by Dan Whitcomb on 5/6/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "JobbieAlert.h"
#import "JobbieCommon.h"

@interface JobbieAlert () <UIAlertViewDelegate>

@property (nonatomic, copy) JobbieAlertBlock block;

@end


@implementation JobbieAlert


+ (void) show:(NSString*)title message:(NSString*)message buttons:(NSArray *)buttons block:(JobbieAlertBlock)block tag:(int)tag style:(UIAlertViewStyle)style
{
    dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       JobbieAlert *alert = [[JobbieAlert alloc] initWithTitle:title
                                                                        message:message
                                                                       delegate:nil
                                                              cancelButtonTitle:[buttons objectAtIndex:0]
                                                              otherButtonTitles:nil];
                       
                       int counter = 0;
                       for( NSString * s in buttons )
                       {
                           if( 0 == counter++ )
                               continue;
                           
                           [alert addButtonWithTitle: s];
                       }
                       
                       alert.delegate = alert;
                       alert.block = block;
                       alert.tag = tag;
                       alert.alertViewStyle = style;
                       
                       [alert show];
                   });
    
}

+ (void) show:(NSString*)title message:(NSString*)message buttons:(NSArray *)buttons block:(JobbieAlertBlock)block tag:(int)tag
{
    [JobbieAlert show:title message:message buttons:buttons block:block tag:tag style:UIAlertViewStyleDefault];
    
}

+ (void) show:(NSString*)title message:(NSString*)message buttons:(NSArray *)buttons block:(JobbieAlertBlock)block
{
	[JobbieAlert show:title message:message buttons:buttons block:block tag:0];
}

+ (void) show:(NSString*)title message:(NSString*)message
{
	[JobbieAlert show:title message:message buttons:[NSArray arrayWithObject:kStrButtonOk] block:nil];
}

+ (void) showError:(NSString*)message
{
	[JobbieAlert show:kStrCommonAlertError message:message];
}



#pragma mark - UIAlertViewDelegate
//
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(self.block)
	{
		self.block(self, buttonIndex);
	}
}

@end