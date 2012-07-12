//
//  LoginView.h
//  sharps
//
//  Created by Eric Lundmark on 2011-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkMediator.h"

@interface LoginView : UIViewController<LoginDelegate,UITextFieldDelegate>{
    NSString *password;
    NSString *username;
    
    UITextField *userNameField;
    UITextField *passwordField;
    
    UILabel *failedNotification;
}
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) IBOutlet UITextField *userNameField;
@property (nonatomic,strong) IBOutlet UITextField *passwordField;
@property (nonatomic,strong) IBOutlet UILabel *failedNotification;

-(IBAction)loginButtonAction;
- (IBAction)backgroundTouched:(id)sender;
@end