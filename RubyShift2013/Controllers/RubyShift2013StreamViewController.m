//
//  RubyShift2013StreamViewController.m
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013StreamViewController.h"

@interface RubyShift2013StreamViewController ()

@end

@implementation RubyShift2013StreamViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Stream", nil);
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    // label
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Pull to Refresh", nil)];
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    // Configure View Controller
    [self setRefreshControl:refreshControl];
    // twitter
    self.twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"jkf4w9QRC1FmQtFlMSgug"
                                                   consumerSecret:@"cPdewnjgopV4CShVPk5LAANdE4AZ6GT0TEHqAQ2vehU"];
    [self updateTwitter];
    // refresh button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(refreshData:)];
}

- (void) updateTwitter {
    
    [self.twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        [self.twitter getSearchTweetsWithQuery:@"backbone" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            //NSLog(@"Search data : %@",searchMetadata);
            //NSLog(@"\n\n Status : %@",statuses);
            self.twitterStatuses = statuses;
            [self.tableView reloadData];
        } errorBlock:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)refreshData:(id)sender
{
    [self updateTwitter];
    if ([sender isKindOfClass:[UIRefreshControl class]]){
        // End Refreshing
        [(UIRefreshControl *)sender endRefreshing];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.twitterStatuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StreamCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *status = [self.twitterStatuses objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [status valueForKey:@"text"];
    cell.detailTextLabel.text = [status valueForKey:@"user.screen_name"];
    
    return cell;
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
