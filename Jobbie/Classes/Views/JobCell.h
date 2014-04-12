//
//  JobCell.h
//  Jobbie
//
//  Created by Dan Whitcomb on 4/7/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblCompNCity;

@end
