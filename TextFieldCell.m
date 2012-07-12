//
//  TextFieldCell.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell
@synthesize subTitle;
@synthesize cellTextField;
@synthesize content;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)prepareForReuse{
    [super prepareForReuse];
    cellTextField.textColor=[UIColor darkTextColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [content setValue:textField.text forKey:[[NSString alloc] initWithFormat:@"%i",self.tag]];
}

@end
