//
//  GameViewController.h
//  sharps
//
//  Created by Eric Lundmark on 2012-01-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCell.h"
#import "ParlayCell.h"
#import "AddGameTableView.h"
@class Parlay;
@class SpreadsheetLibrary;
@interface GamesViewController : UITableViewController{
    NSMutableDictionary *spreadsheet;
    NetworkMediator *networkMediator;
    NSMutableArray *selectedRowIndex;
    NSMutableArray *games;
}
@property(nonatomic,strong)NSMutableDictionary *spreadsheet;
@property(nonatomic,strong) NetworkMediator *networkMediator;
@property(nonatomic,strong)NSMutableArray *selectedRowIndex;
@property(nonatomic,strong) NSMutableArray *games;
@end
