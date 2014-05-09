//
//  JBTextField.m
//  Jobbie
//
//  Created by Dan Whitcomb on 5/8/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "JBTextField.h"

@implementation JBTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
