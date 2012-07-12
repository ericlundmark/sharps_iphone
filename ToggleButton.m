//
//  ToggleButton.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-05-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToggleButton.h"

@implementation ToggleButton
@synthesize title;
@synthesize image;
@synthesize toggled;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        toggled=NO;
        [self addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.backgroundColor=[UIColor whiteColor];
        title=[[UILabel alloc] initWithFrame: CGRectMake(0, 0, 74.0, 26.0)];
        title.opaque=YES;
        title.backgroundColor=[UIColor clearColor];
        title.text=@"Title";
        title.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        title.textAlignment=UITextAlignmentCenter;
        [title autoresizingMask];
        [self addSubview:title];
    }
    return self;
}
-(IBAction)toggle:(id)sender{
    toggled=!toggled;
    if (toggled) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
        img.tag=2;
        img.image=image;
        [self addSubview:img];
        [self sendSubviewToBack:img];
    }else{
        [[self viewWithTag:2] removeFromSuperview];
    }
    
}
@end
