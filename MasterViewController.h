//
//  MasterViewController.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class NetworkMediator;
#import "SpreadsheetLibrary.h"
#import "SpreadsheetCell.h"
#import "GamesViewController.h"
#import "LoginView.h"

@interface MasterViewController : UITableViewController{
    SpreadsheetLibrary *library;
    NetworkMediator *networkMediator;
    UIActivityIndicatorView *activityIndicatorView;
    UIBarButtonItem *rightNavButton;
    
}
@property (nonatomic, retain) UIBarButtonItem *rightNavButton;
@property (nonatomic, strong) SpreadsheetLibrary *library;
@property (nonatomic, strong) NetworkMediator *networkMediator;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;


@property (strong, nonatomic) DetailViewController *detailViewController;
- (IBAction)updateSheets:(id)sender;

@end
