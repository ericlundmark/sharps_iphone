//
//  ParlayCell.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParlayCell.h"

@implementation ParlayCell
@synthesize parlay;
@synthesize numberOfGamesLabel;
@synthesize nettoLabel;
@synthesize extended;
-(void)initContent{
    for (int i=0; i<((NSMutableArray*)[self.parlay objectForKey:@"subgames"]).count; i++) {
        NSMutableDictionary *game=[((NSMutableArray*)[self.parlay objectForKey:@"subgames"]) objectAtIndex:i];
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 80+(80*i), 320, 20)];
        img.image=[UIImage imageNamed:@"redButton.png"];
        img.alpha=0;
        [self.contentView addSubview:img];
        [self sendSubviewToBack:img];
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(9, 83+(80*i), self.contentView.bounds.size.width, 13)];
        title.font = [UIFont boldSystemFontOfSize:11];
        title.text=[[NSString alloc] initWithFormat:@"%@-%@ %@ %@",[game objectForKey:@"team1"],[game objectForKey:@"team2"],[game objectForKey:@"sign"],[game objectForKey:@"sign2"]];
        title.backgroundColor=[UIColor clearColor];
        title.textColor=[UIColor whiteColor];
        [self.contentView addSubview:title];
        title.alpha=0;
        title.tag=1;
        img.tag=1;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.contentView.subviews) {
        if (view.tag==1) {
            view.frame=CGRectMake(0, view.frame.origin.y, self.frame.size.width, 20);
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)prepareForReuse{
    [super prepareForReuse];
    [self.backgroundView removeFromSuperview];
}
-(void)extendCell{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 320, self.frame.size.height-80)] ;
    [view setBackgroundColor:[UIColor darkGrayColor]];
    [self setBackgroundView:view];
    for (UIView *view in [self.contentView subviews]) {
        if (view.tag ==1) {
            [UIView animateWithDuration:0.8 animations:^(void) {
                view.alpha = 0;
                view.alpha = 1;
                self.backgroundView.alpha=0;
                self.backgroundView.alpha=1;
            }];                    
        }
    }
    self.extended=YES;
}
-(void)retractCell{
    for (UIView *view in [self.contentView subviews]) {
        if (view.tag ==1) {
            [UIView animateWithDuration:0.3 animations:^(void) {
                view.alpha = 1;
                view.alpha = 0;
                self.backgroundView.alpha=1;
                self.backgroundView.alpha=0;
            }]; 
        }
    }
    [self.backgroundView removeFromSuperview];
    self.extended=NO;
}
@end