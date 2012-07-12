//
//  TextFieldCell.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell<UITextFieldDelegate>{
    UILabel *subTitle;
    UITextField *cellTextField;
    NSMutableDictionary *content;
}
@property (nonatomic,strong) IBOutlet UILabel *subTitle;
@property (nonatomic,strong) IBOutlet UITextField *cellTextField;
@property (nonatomic,strong) NSMutableDictionary *content;
-(IBAction)textFieldReturn:(id)sender;
@end
