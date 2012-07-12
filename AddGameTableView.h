//
//  AddGameTableView.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"
#import "LiveAndLockCell.h"
#import "ArrayTableViewController.h"
#import "NetworkMediator.h"
#import "ResultCell.h"

@interface AddGameTableView : UITableViewController<UIGestureRecognizerDelegate>{
    NSArray *textCellTitles;
    NSArray *detailCellTitles;
    NSArray *keys;
    NSMutableDictionary *spreadsheet;
    NSIndexPath *currentCellIndexPath;
    NSArray *dataValues;
    NetworkMediator *networkMediator;
    TableModes mode;
    NSMutableDictionary *game;
    NSMutableDictionary *content;
    NSIndexPath *resultCellIndexPath;
    NSIndexPath *timeCellIndexPath;
    NSIndexPath *dateCellIndexPath;
    BOOL resultCellExpanded;
}
@property (nonatomic,strong)NSArray *textCellTitles;
@property (nonatomic,strong)NSArray *detailCellTitles;
@property (nonatomic,strong)NSArray *keys;
@property (nonatomic,strong)NSMutableDictionary *spreadsheet;
@property (nonatomic,strong)NSIndexPath *currentCellIndexPath;
@property (nonatomic,strong)NSArray *dataValues;
@property (nonatomic,strong)NetworkMediator *networkMediator;
@property (nonatomic,strong)NSMutableDictionary *game;
@property (nonatomic,strong)NSMutableDictionary *content;
@property (nonatomic,strong)NSIndexPath *resultCellIndexPath;
@property (nonatomic,strong)NSIndexPath *timeCellIndexPath;
@property (nonatomic,strong)NSIndexPath *dateCellIndexPath;
@property (nonatomic)BOOL resultCellExpanded;
@property (nonatomic)TableModes mode;
-(void)layGame;
-(NSMutableString*)stringFromTextfieldCellAtRow:(NSInteger)row InSection:(NSInteger) section;
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
-(IBAction)pickerDoneClicked:(id)sender;
@end
