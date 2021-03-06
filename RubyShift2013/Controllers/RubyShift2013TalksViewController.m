//
//  RubyShift2013AgendaViewController.m
//  RubyShift2013
//
//  Created by Alex on 8/26/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "RubyShift2013TalksViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Talk.h"
#import "Speaker.h"
#import "RubyShift2013TalkDetailsViewController.h"

@interface RubyShift2013TalksViewController () <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *_fetchedResultsController;
}

- (void)refetchData;

@end

@implementation RubyShift2013TalksViewController

- (void)refetchData {
    [_fetchedResultsController performSelectorOnMainThread:@selector(performFetch:) withObject:nil waitUntilDone:YES modes:@[ NSRunLoopCommonModes ]];
}


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
    
    self.title = NSLocalizedString(@"Talks", nil);
    
    [self changeDate:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refetchData)];
}

- (void) initFetchController {
    
}

- (void)initDates:(id)sender {
    int index = 0;
    if (sender && [sender isKindOfClass:[UISegmentedControl class]]){
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        index = [segmentedControl selectedSegmentIndex];
    }
    NSDateComponents *comps = [NSDateComponents new];
    [comps setDay:27];
    [comps setMonth:9];
    [comps setYear:2013];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    [comps setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    self.beginDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    if (index == 1) {
        self.beginDate = [self.beginDate dateByAddingTimeInterval: +86400.0];
    }
    self.endDate = [self.beginDate dateByAddingTimeInterval: +86400.0];
}

- (IBAction)changeDate:(id)sender {
    
    [self initDates:sender];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Talk"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"talkDate" ascending:YES]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(talkDate >= %@) AND (talkDate < %@) AND (isFullDeleted == %@)", self.beginDate, self.endDate, [NSNumber numberWithBool:NO]]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    [self refetchData];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TalkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Talk *talk = (Talk *)[_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [talk valueForKey:@"talkTitle"];

    if (talk.speaker){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", [talk valueForKey:@"talkTimeRange"], [[talk speaker] valueForKey:@"speakerFullName"]];
        [cell.imageView setImageWithURL:[NSURL URLWithString:[[talk speaker] valueForKey:@"speakerPhoto"]]
                       placeholderImage:[UIImage imageNamed:@"speaker_icon.png"]];
    }
    
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"talkCellPressed"]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        RubyShift2013TalkDetailsViewController *tdv = [segue destinationViewController];
        tdv.talk = (Talk *)[_fetchedResultsController objectAtIndexPath:indexPath];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
