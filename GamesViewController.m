//
//  GameViewController.m
//  sharps
//
//  Created by Eric Lundmark on 2012-01-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamesViewController.h"
#import "SpreadsheetLibrary.h"
@implementation GamesViewController
@synthesize spreadsheet;
@synthesize networkMediator;
@synthesize selectedRowIndex;
@synthesize games;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [spreadsheet objectForKey:@"title"];
    self.selectedRowIndex=[[NSMutableArray alloc] init];
    self.networkMediator=[NetworkMediator sharedInstance];
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"pushAdd"]){
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"UpdateGames" object:nil];
        ((AddGameTableView*)segue.destinationViewController).mode=Add;
        ((AddGameTableView*)segue.destinationViewController).spreadsheet=self.spreadsheet;
    }else if([[segue identifier] isEqualToString:@"pushEdit"]){
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"UpdateGames" object:nil];
        if([[spreadsheet objectForKey:@"group"] isEqualToString:@"my"]){
            ((AddGameTableView*)segue.destinationViewController).mode=Edit;
            ((AddGameTableView*)segue.destinationViewController).navigationItem.title=@"Ändra spel";
        }else{
            ((AddGameTableView*)segue.destinationViewController).mode=View;
            ((AddGameTableView*)segue.destinationViewController).navigationItem.title=@"Granska spel";
        }
        ((AddGameTableView*)segue.destinationViewController).game=((GameCell*)sender).game;
        ((AddGameTableView*)segue.destinationViewController).spreadsheet=self.spreadsheet;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        return YES;
    }
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    self.games=[networkMediator.library.games objectForKey:[self.spreadsheet objectForKey:@"id"]];
    if (((NSString*)[spreadsheet objectForKey:@"games"]).integerValue > [games count]) {
        return [games count]+1;
    } else {
        return [games count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Initiering av en GameCell
    if(indexPath.row<[games count]&&[[[games objectAtIndex:indexPath.row] objectForKey:@"parlay"] isEqualToString:@"0"]){
        static NSString *CellIdentifier = @"GameCell";
        
        GameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[GameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSMutableDictionary *game=[games objectAtIndex:indexPath.row];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            cell.teams.text=[[NSString alloc] initWithFormat:@"%@-%@ %@ %@  %@ %@",[game objectForKey:@"team1"],[game objectForKey:@"team2"],[game objectForKey:@"sign"],[game objectForKey:@"sign2"],[game objectForKey:@"date"],[game objectForKey:@"time"]];
        }else{
            cell.teams.text=[[NSString alloc] initWithFormat:@"%@-%@ %@ %@",[game objectForKey:@"team1"] ,[game objectForKey:@"team2"],[game objectForKey:@"sign"],[game objectForKey:@"sign2"]];
        }
        cell.odds.text=[game objectForKey:@"odds"];
        cell.stake.text=[game objectForKey:@"amount"];
        cell.netto.text=[game objectForKey:@"result"];
        cell.spreadsheet=spreadsheet;
        cell.game=game;
        if (cell.netto.text.length>0&&[cell.netto.text characterAtIndex:0]=='-'){
            cell.netto.textColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        }else if (cell.netto.text.length>0&&[cell.netto.text doubleValue]!=0) {
            cell.netto.textColor=[UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        }
        cell.tag=0;
        return cell;
    }
    //Initiering av en parlayCell
    else if (indexPath.row<[games count]&&![[spreadsheet objectForKey:@"parlay"]isEqualToString:@"0"] ) {
        static NSString *CellIdentifier = @"ParlayCell";
        
        ParlayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ParlayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSMutableDictionary *parlay=[games objectAtIndex:indexPath.row];
        cell.parlay=parlay;
        cell.nettoLabel.text=[parlay objectForKey:@"result"];
        cell.numberOfGamesLabel.text=[[NSString alloc] initWithFormat:@"Parlay med %i spel",((NSMutableArray*)[parlay objectForKey:@"subgames"]).count];
        [cell initContent];
        if([selectedRowIndex containsObject:indexPath]) {
            [cell extendCell];
        }
        cell.tag=0;
        return cell;
    }
    //Initiering av LoadingCell
    else{
        static NSString *CellIdentifier = @"LoadingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.tag=1;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If last section is about to be shown...
    if (cell.tag==1&&![[networkMediator.downloading objectForKey:[spreadsheet objectForKey:@"id"]] isEqualToString:@"yes"]) {
        [networkMediator.downloading setObject:@"yes" forKey:[spreadsheet objectForKey:@"id"]];
        [networkMediator getGamesForSpreadsheet:spreadsheet];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //check if the index actually exists
    if([selectedRowIndex containsObject:indexPath]) {
        ParlayCell *tmp=(ParlayCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return (80*((NSMutableArray*)[tmp.parlay objectForKey:@"subgames"]).count)+80;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ParlayCell class]]) {
        ParlayCell *cell=(ParlayCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell.extended) {
            [selectedRowIndex addObject:indexPath];
            [tableView beginUpdates];
            [cell extendCell];
            [tableView endUpdates];
        }else{
            [selectedRowIndex removeObject:indexPath];
            [tableView beginUpdates];
            [cell retractCell];
            [tableView endUpdates];
        }
        
    }
}
@end
