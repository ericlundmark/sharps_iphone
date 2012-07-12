//
//  GameCell.m
//  sharps
//
//  Created by Eric Lundmark on 2012-01-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell
@synthesize teams;
@synthesize odds;
@synthesize stake;
@synthesize spreadsheet;
@synthesize game;
@synthesize netto;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)prepareForReuse{
    [super prepareForReuse];
    netto.textColor=[UIColor darkTextColor];
}
@end
