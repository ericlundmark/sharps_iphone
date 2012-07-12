//
//  SpreadsheetCell.m
//  sharps
//
//  Created by Eric Lundmark on 2011-12-22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SpreadsheetCell.h"

@implementation SpreadsheetCell
@synthesize ROI;
@synthesize title;
@synthesize lastGame;
@synthesize sheet;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
//Metod för att knyta ett sheet till en cell
-(void)attachSpreadsheet:(NSMutableDictionary*)spreadsheet{
    self.sheet=spreadsheet;
    title.text=[sheet objectForKey:@"title"];
    ROI.text=[sheet objectForKey:@"roi"];
    if (ROI.text.integerValue>=100) {
        ROI.textColor=[UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    } else if(ROI.text.integerValue!=0) {
        ROI.textColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
    lastGame.text=[sheet objectForKey:@"lastGame"];
}
- (void)prepareForReuse{
    [super prepareForReuse];
    ROI.textColor=[UIColor darkTextColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
