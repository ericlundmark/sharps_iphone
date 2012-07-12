//
//  SpreadsheetCell.h
//  sharps
//
//  Created by Eric Lundmark on 2011-12-22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpreadsheetCell : UITableViewCell{
    UILabel *ROI;
    UILabel *title;
    UILabel *lastGame;
    NSMutableDictionary *sheet;
}
@property (nonatomic,strong) IBOutlet UILabel *ROI;
@property (nonatomic,strong) IBOutlet UILabel *title;
@property (nonatomic,strong) IBOutlet UILabel *lastGame;
@property (nonatomic,strong) NSMutableDictionary *sheet;
-(void)attachSpreadsheet:(NSMutableDictionary*)spreadsheet;
@end
