//
//  LeftViewController.m
//  Jobbie
//
//  Created by Dan Whitcomb on 11/16/13.
//  Copyright (c) 2013 Jobbie. All rights reserved.
//

#import "LeftViewController.h"


//Menu item tags
#define OPP_TAG 0
#define MATCH_TAG 1
#define PROFILE_TAG 2
#define SETTINGS_TAG 3

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _controllerMethods = [[ControllerMethods alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
//tableView didSeleceRowAtIndexPath
//Identifies which table item is chosen and
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UIViewController* viewController = nil;
    
    switch(row){
        case OPP_TAG:{
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OpportunityViewController"];
            break;
        }

        case MATCH_TAG:{
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MatchesViewController"];
            break;
        }
        
        case PROFILE_TAG:{
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
            break;
        }
            
        case SETTINGS_TAG:{
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
            break;
        }
        default:{
            NSLog(@"Chosen item not recognized");
            break;
        }
    }
    
    [self.navigationController pushViewController:viewController animated:YES];

}
 */

#pragma mark - Table view data source

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
