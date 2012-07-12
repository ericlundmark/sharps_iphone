//
//  LiveAndLockCell.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveAndLockCell : UITableViewCell{
    UISwitch *live;
    UISwitch *lock;
}
@property(nonatomic,strong)IBOutlet UISwitch *live;
@property(nonatomic,strong)IBOutlet UISwitch *lock;
@end
