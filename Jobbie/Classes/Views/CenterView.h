//
//  CenterView.h
//  Jobbie
//
//  Created by Dan Whitcomb on 11/27/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomRect.h"

@interface CenterView : UIView

//Interface Rectangles
@property CustomRect* headerRect;
@property CustomRect* mainInfoRect;
@property CustomRect* statsLeftRect;
@property CustomRect* statsMidRect;
@property CustomRect* statsRightRect;
@property CustomRect* descriptRect;

//Buttons
@property (strong, nonatomic) IBOutlet UIButton *xButton;
@property (strong, nonatomic) IBOutlet UIButton *matchButton;
@property (strong, nonatomic) IBOutlet UIButton *drawerButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;


//Labels and Images
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLocationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *jobImageView;
@property (strong, nonatomic) IBOutlet UILabel *matchStatLabel;
@property (strong, nonatomic) IBOutlet UILabel *xStatLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingStatLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptLabel;


@end
