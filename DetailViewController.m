//
//  DetailViewController.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize tableView;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize games;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if ([self.detailItem class]==[LoginView class]) {
        [self.navigationController pushViewController:self.detailItem animated:NO];
    }else if([self.detailItem class]==[GamesViewController class]){
        games=((GamesViewController*)self.detailItem);
        games.tableView=self.tableView;
        games.tableView.dataSource=games;
        games.tableView.delegate=games;
        [games.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"pushAdd"]){
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"UpdateGames" object:nil];
        ((AddGameTableView*)segue.destinationViewController).mode=Add;
        ((AddGameTableView*)segue.destinationViewController).spreadsheet=games.spreadsheet;
    }else if([[segue identifier] isEqualToString:@"pushEdit"]){
        [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"UpdateGames" object:nil];
        if([[games.spreadsheet objectForKey:@"group"] isEqualToString:@"my"]){
            ((AddGameTableView*)segue.destinationViewController).mode=Edit;
            ((AddGameTableView*)segue.destinationViewController).navigationItem.title=@"Ändra spel";
        }else{
            ((AddGameTableView*)segue.destinationViewController).mode=View;
            ((AddGameTableView*)segue.destinationViewController).navigationItem.title=@"Granska spel";
        }
        ((AddGameTableView*)segue.destinationViewController).game=((GameCell*)sender).game;
        ((AddGameTableView*)segue.destinationViewController).spreadsheet=games.spreadsheet;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    LoginView *login = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [login.navigationItem setHidesBackButton:YES animated:YES];
    [self setDetailItem:login];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
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

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Sheets", @"Sheets");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
