//
//  ResultCell.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-05-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkMediator.h"
#import "ToggleButton.h"
@interface ResultCell : UITableViewCell{
    ToggleButton *win;
    ToggleButton *push;
    ToggleButton *loss;
    NetworkMediator *mediator;
    NSMutableDictionary *game;
    NSMutableDictionary *spreadsheet;
    BOOL extended;
}
@property (nonatomic,strong) ToggleButton *win;
@property (nonatomic,strong) ToggleButton *push;
@property (nonatomic,strong) ToggleButton *loss;
@property (nonatomic,strong)NetworkMediator *mediator;
@property (nonatomic,strong)NSMutableDictionary *game;
@property (nonatomic,strong)NSMutableDictionary *spreadsheet;
@property (nonatomic)BOOL extended;
-(IBAction)winButtonPushed:(id)sender;
-(IBAction)pushButtonPushed:(id)sender;
-(IBAction)lossButtonPushed:(id)sender;
-(IBAction)voidButtonPushed:(id)sender;
-(IBAction)halfLossButtonPushed:(id)sender;
-(IBAction)halfWinButtonPushed:(id)sender;
-(void)loadContentView;
-(void)removeContentView;
-(void)resetButtons;
@end
