//
//  GameCell.h
//  sharps
//
//  Created by Eric Lundmark on 2012-01-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GameCell : UITableViewCell{
    UILabel *teams;
    UILabel *odds;
    UILabel *stake;
    UILabel *netto;
    NSMutableDictionary *spreadsheet;
    NSMutableDictionary *game;
}
@property (nonatomic,strong)IBOutlet UILabel *teams;
@property (nonatomic,strong)IBOutlet UILabel *odds;
@property (nonatomic,strong)IBOutlet UILabel *stake;
@property (nonatomic,strong)IBOutlet UILabel *netto;
@property (nonatomic,strong)NSMutableDictionary *spreadsheet;
@property (nonatomic,strong)NSMutableDictionary *game;
@end
