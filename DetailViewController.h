//
//  DetailViewController.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamesViewController.h"
#import "LoginView.h"
#import "SpreadsheetLibrary.h"
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>{
    GamesViewController *games;
    UITableView *tableView;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) GamesViewController *games;
@end
