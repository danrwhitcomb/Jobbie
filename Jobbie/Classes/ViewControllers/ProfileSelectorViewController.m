//
//  ProfileSelectorViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 4/7/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "ProfileSelectorViewController.h"
#import "Model.h"
#import "ProfileCellView.h"

@implementation ProfileSelectorViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray* arr = [[Model sharedModel] searchProfiles];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectProfileCell";
    ProfileCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (ProfileCellView*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SearchProfile* prof = [[[Model sharedModel] searchProfiles] objectAtIndex:indexPath.row];
    
    cell.lblName.text = prof.name;
    cell.lblKeyword.text = prof.jobType;
    return cell;
}

@end
