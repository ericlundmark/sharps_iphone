//
//  LoginView.m
//  sharps
//
//  Created by Eric Lundmark on 2011-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

@synthesize password;
@synthesize username;
@synthesize userNameField;
@synthesize passwordField;
@synthesize failedNotification;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) viewWillDisappear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    self.navigationItem.title=@"Sharps.se";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    username=@"luntfen";
    password=@"ERIlun849";
}
//Startar inloggningen
-(IBAction)loginButtonAction{
    NetworkMediator *nm=[NetworkMediator sharedInstance];
    nm.loginDelegate=self;
    //username=userNameField.text;
    //password=passwordField.text;
    //Startar ett inloggningsförsök
    [nm doLogin:username :password];
}
#pragma mark - NetworkMediatorDelegate
//Undersöker om inloggningen var lyckad, om inte så visas en notifiering.
- (void)loginDidSucceed:(BOOL)succeeded{
    if (succeeded) {
       [self.navigationController popViewControllerAnimated:YES]; 
    }else{
        failedNotification.hidden=NO;
    }
}
#pragma mark-ended
//------Hantering av tangentbordet-------
//Vid tryckning i bakgrunden
-(IBAction)backgroundTouched:(id)sender
{
    [userNameField resignFirstResponder];
    [passwordField resignFirstResponder];
}
//Tryckning på return-knappen
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
//----Slut på hantering av tangentbord----
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
