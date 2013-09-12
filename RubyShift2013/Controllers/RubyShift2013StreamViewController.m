//
//  RubyShift2013StreamViewController.m
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "RubyShift2013StreamViewController.h"
#import "StreamTableViewCell.h"

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
        
        [self.twitter getSearchTweetsWithQuery:@"#rubyshift" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
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

    StreamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[StreamTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [cell setTwitterStatus:[self.twitterStatuses objectAtIndex:indexPath.row]];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *twit = [self.twitterStatuses objectAtIndex:indexPath.row];
    return [StreamTableViewCell heightForCellWithTwit:twit];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *twit = [self.twitterStatuses objectAtIndex:indexPath.row];
    NSString *url = [NSString stringWithFormat:@"https://twitter.com/%@/status/%@", twit[@"user"][@"screen_name"], [twit valueForKey:@"id"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


@end
