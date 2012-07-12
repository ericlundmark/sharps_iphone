//
//  ToggleButton.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-05-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ToggleButton : UIControl{
    UILabel *title;
    UIImage *image;
    BOOL toggled;
}
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic)BOOL toggled;
-(IBAction)toggle:(id)sender;
@end
