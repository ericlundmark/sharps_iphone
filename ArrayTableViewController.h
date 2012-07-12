//
//  ArrayTableViewController.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"
@interface ArrayTableViewController : UITableViewController{
    NSMutableArray *dataArray;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
