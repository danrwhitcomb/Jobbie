//
//  ProfilesTable.m
//  Jobbie
//
//  Created by Dan Whitcomb on 4/5/14.
//  Copyright (c) 2014 Jobbie. All rights reserved.
//

#import "ProfilesTableController.h"
#import "AddProfileViewController.h"

#import "Model.h"
#import "ProfileCellView.h"

@interface ProfilesTableController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblKeywords;
@property (strong, nonatomic) IBOutlet ProfileCellView *cellView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnAdd;
@property (strong, nonatomic) IBOutlet UIBarButtonItem * btnEdit;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@end

@implementation ProfilesTableController

-(void)viewDidLoad
{
    self.tableView.rowHeight = 70;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(IBAction)onBtnDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)onBtnEdit:(id)sender
{
    [self setEditing:YES animated:YES];
}

- (IBAction)onBtnDoneEditing:(id)sender {
    [self setEditing:NO animated:YES];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if(editing){
        self.navigationItem.rightBarButtonItem = self.btnAdd;
        self.navigationItem.leftBarButtonItem = self.btnDone;
    } else {
        self.navigationItem.rightBarButtonItem = self.btnEdit;
        self.navigationItem.leftBarButtonItem = self.btnBack;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if([segue.identifier isEqualToString:@"rowSelection"])
    {
        AddProfileViewController* vc = segue.destinationViewController;
        vc.navigationController.navigationItem.title = @"Edit Profile";
        
        Model* model = [Model sharedModel];
        SearchProfile* prof = [[model searchProfiles] objectAtIndex:indexPath.row];
        
        vc.textName.text = prof.name;
        vc.textType.text = prof.jobType;
        vc.textLocation.text = prof.location;
        vc.textCompany.text = prof.company;
        vc.textDistance.text = prof.radius;
        
        vc.btnCreate.titleLabel.text = @"Save Profile";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Model* model = [Model sharedModel];
    
    return [[model searchProfiles] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    
    // Configure the cell...
    Model* model = [Model sharedModel];
    SearchProfile* prof = [[model searchProfiles] objectAtIndex:indexPath.row];
    
    cell.lblName.text = prof.name;
    
    NSString* keyword = [prof.jobType stringByAppendingString:@" - "];
    keyword = [keyword stringByAppendingString:prof.location];
    cell.lblKeyword.text = keyword;
    
    /*
    float widthIs =
    [cell.lblName.text
     boundingRectWithSize:cell.lblName.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:cell.lblName.font }
     context:nil]
    .size.width + 5;
    
    cell.lblKeyword.frame = CGRectMake(widthIs, cell.lblKeyword.frame.origin.y, self.view.frame.size.width - widthIs, self.view.frame.size.height);
    */
    return cell;
}


@end
