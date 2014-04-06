//
//  AddProfileViewController.h
//  Jobbie
//
//  Created by Dan Whitcomb on 4/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textType;
@property (strong, nonatomic) IBOutlet UITextField *textLocation;
@property (strong, nonatomic) IBOutlet UITextField *textCompany;
@property (strong, nonatomic) IBOutlet UITextField *textDistance;

@property (strong, nonatomic) IBOutlet UIButton *btnCreate;

@end
