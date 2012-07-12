//
//  MasterViewController.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NetworkMediator.h"
@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize library;
@synthesize networkMediator;
@synthesize activityIndicatorView;
@synthesize rightNavButton;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.navigationItem.title=@"Spreadsheets";
    networkMediator=[NetworkMediator sharedInstance];
    
    networkMediator.masterView=self;
    rightNavButton=self.detailViewController.navigationItem.rightBarButtonItem;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Avoids crash when backing from loading gameTableView
    networkMediator.tableView=Nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"Mina spreadsheets";
    } else {
        return @"Mina Favorit spreadsheets";
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return [networkMediator.library.my count];
    }
    return [networkMediator.library.fav count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpreadsheetCell";
    
    SpreadsheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SpreadsheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section==0&&networkMediator.library.my.count >0) {
        [cell attachSpreadsheet:[networkMediator.library.my objectAtIndex:indexPath.row]];
    } else if(indexPath.section==1&&networkMediator.library.fav.count >0) {
        [cell attachSpreadsheet:[networkMediator.library.fav objectAtIndex:indexPath.row]];
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
*/
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        GamesViewController *games = [[GamesViewController alloc] init];
        games.spreadsheet= ((SpreadsheetCell*)[tableView cellForRowAtIndexPath:indexPath]).sheet;
        NSString *key=[games.spreadsheet objectForKey:@"id"];
        games.games=[networkMediator.library.games objectForKey:key];
        if ([self.tableView indexPathForSelectedRow].section==1) {
            rightNavButton=self.detailViewController.navigationItem.rightBarButtonItem;
            [self.detailViewController.navigationItem setRightBarButtonItem:nil animated:YES];
        }else{
            [self.detailViewController.navigationItem setRightBarButtonItem:rightNavButton animated:YES];
        }
        networkMediator.tableView=self.detailViewController.tableView;
        games.networkMediator=networkMediator;
        self.detailViewController.navigationItem.title = [games.spreadsheet objectForKey:@"title"];
        games.selectedRowIndex=[[NSMutableArray alloc] init];
        [self.detailViewController setDetailItem:games];
    } 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"pushGames"]){
        ((GamesViewController*)segue.destinationViewController).spreadsheet=((SpreadsheetCell*)sender).sheet;
        NSString *key=[((SpreadsheetCell*)sender).sheet objectForKey:@"id"];
        ((GamesViewController*)segue.destinationViewController).games=[networkMediator.library.games objectForKey:key];
        if ([self.tableView indexPathForSelectedRow].section==1) {
            ((GamesViewController*)segue.destinationViewController).navigationItem.rightBarButtonItem=nil;
        }
        networkMediator.tableView= ((GamesViewController*)segue.destinationViewController).tableView;
    }
}

- (IBAction)updateSheets:(id)sender {
    [networkMediator updateSpreadsheets];
}
@end
