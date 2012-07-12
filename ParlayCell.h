//
//  ParlayCell.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ParlayCell : UITableViewCell{
    NSMutableDictionary *parlay;
    UILabel *numberOfGamesLabel;
    UILabel *nettoLabel;
    BOOL extended;
}
@property(nonatomic,strong)NSMutableDictionary *parlay;
@property(nonatomic,strong)IBOutlet UILabel *numberOfGamesLabel;
@property(nonatomic,strong)IBOutlet UILabel *nettoLabel;
@property(nonatomic)BOOL extended;
-(void)extendCell;
-(void)retractCell;
-(void)initContent;
@end
