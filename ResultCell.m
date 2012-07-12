//
//  ResultCell.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-05-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultCell.h"

@implementation ResultCell
@synthesize win;
@synthesize push;
@synthesize loss;
@synthesize mediator;
@synthesize game;
@synthesize spreadsheet;
@synthesize extended;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        mediator=[NetworkMediator sharedInstance];
        win = [[ToggleButton alloc] init];
        [win addTarget:self 
                action:@selector(winButtonPushed:)
      forControlEvents:UIControlEventTouchUpInside];
        win.title.text=@"win";
        win.image=[UIImage imageNamed:@"greenButton.png"];
        [self.contentView addSubview:win];
        loss = [[ToggleButton alloc] init];
        [loss addTarget:self 
                 action:@selector(lossButtonPushed:)
       forControlEvents:UIControlEventTouchUpInside];
        loss.title.text=@"loss";
        loss.image=[UIImage imageNamed:@"redButton.png"];
        [self.contentView addSubview:loss];
        push = [[ToggleButton alloc] init];
        [push addTarget:self 
                 action:@selector(pushButtonPushed:)
       forControlEvents:UIControlEventTouchUpInside];
        push.title.text=@"push";
        push.image=[UIImage imageNamed:@"greyButton.png"];
        [self.contentView addSubview:push];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    int center=(self.contentView.frame.size.width-94)/2;
    win.frame= CGRectMake(center+94, 7.0, 74.0, 26.0);
    push.frame= CGRectMake(center, 7.0, 74.0, 26.0);
    loss.frame= CGRectMake(center-94, 7.0, 74.0, 26.0);
    
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        mediator=[NetworkMediator sharedInstance];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)resetButtons{
    for (id view in self.contentView.subviews) {
        if ([view isMemberOfClass:[ToggleButton class]]) {
            ToggleButton *toggle=(ToggleButton*)view;
            if (toggle.toggled) {
                [toggle toggle:toggle];
            }
        }
    }
}
-(IBAction)winButtonPushed:(id)sender{
    [mediator setResult:@"win" toGame:game inSpreadsheet:spreadsheet];
    [self resetButtons];
    [win toggle:win];
}
-(IBAction)pushButtonPushed:(id)sender{
    [mediator setResult:@"push" toGame:game inSpreadsheet:spreadsheet];
    [self resetButtons];
    [push toggle:push];
}
-(IBAction)lossButtonPushed:(id)sender{
    [mediator setResult:@"loss" toGame:game inSpreadsheet:spreadsheet];
    [self resetButtons];
    [loss toggle:loss];
}
-(IBAction)voidButtonPushed:(id)sender{
    [mediator setResult:@"void" toGame:game inSpreadsheet:spreadsheet];
    [self resetButtons];
    [push toggle:push];
}
-(IBAction)halfWinButtonPushed:(id)sender{
    [mediator setResult:@"halfwin" toGame:game inSpreadsheet:spreadsheet];
    [self resetButtons];
    [win toggle:win];
}
-(IBAction)halfLossButtonPushed:(id)sender{
    [mediator setResult:@"halfloss" toGame:game inSpreadsheet:spreadsheet];
    [self resetButtons];
    [loss toggle:loss];
}
-(void)loadContentView{
    int center=(self.contentView.frame.size.width-94)/2;
    ToggleButton *voids = [[ToggleButton alloc] initWithFrame:CGRectMake(center+94, 40.0, 74.0, 26.0)];
    [voids addTarget:self 
              action:@selector(voidButtonPushed:)
    forControlEvents:UIControlEventTouchDown];
    voids.title.text=@"void";
    voids.image=[UIImage imageNamed:@"greyButton.png"];
    voids.tag=1;
    voids.alpha=0;
    [self.contentView addSubview:voids];
    ToggleButton *halfWin = [[ToggleButton alloc] initWithFrame:CGRectMake(center, 40.0, 74.0, 26.0)];
    [halfWin addTarget:self 
                action:@selector(halfWinButtonPushed:)
      forControlEvents:UIControlEventTouchDown];
    halfWin.title.text=@"1/2 win";
    halfWin.image=[UIImage imageNamed:@"greyButton.png"];
    halfWin.tag=1;
    halfWin.alpha=0;
    [self.contentView addSubview:halfWin];
    ToggleButton *halfLoss = [[ToggleButton alloc] initWithFrame:CGRectMake(center-94,40.0, 74.0, 26.0)];
    [halfLoss addTarget:self 
                 action:@selector(halfLossButtonPushed:)
       forControlEvents:UIControlEventTouchDown];
    halfLoss.title.text=@"1/2 loss";
    halfLoss.image=[UIImage imageNamed:@"greyButton.png"];
    halfLoss.tag=1;
    halfLoss.alpha=0;
    [self.contentView addSubview:halfLoss];
    [UIView animateWithDuration:0.8 animations:^(void) {
        halfLoss.alpha = 0;
        halfLoss.alpha = 1;
    }];
    [UIView animateWithDuration:0.8 animations:^(void) {
        halfWin.alpha = 0;
        halfWin.alpha = 1;
    }];
    [UIView animateWithDuration:0.8 animations:^(void) {
        voids.alpha = 0;
        voids.alpha = 1;
    }];
}
-(void)removeContentView{
    for (UIView *view in self.contentView.subviews) {
        if(view.tag==1){
            [UIView animateWithDuration:0.8 animations:^(void) {
                view.alpha = 1;
                view.alpha = 0;
            }];
            [view removeFromSuperview];
        }
    }
}
@end
