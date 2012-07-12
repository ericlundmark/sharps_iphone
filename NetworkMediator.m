//
//  NetworkMediator.m
//  sharps
//
//  Created by Eric Lundmark on 2011-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkMediator.h"
#import "SpreadsheetLibrary.h"
#import "Connection.h"
#import "Request.h"
#import "SpreadsheetRequestOP.h"
#import "GetGamesOP.h"
#import "GameUploadOperation.h"
@implementation NetworkMediator
@synthesize library;
@synthesize loginDelegate;
@synthesize sheetsFinishedLoading;
@synthesize sheetsFailedLoading;
@synthesize masterView;
@synthesize tableView;
@synthesize downloading;

static NetworkMediator *sharedNetworkMediator;

//Initierar singletonen
+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedNetworkMediator = [[NetworkMediator alloc] init];
        sharedNetworkMediator.downloading=[[NSMutableDictionary alloc] init];
    }
}
//Returnerar den delade instansen
+(NetworkMediator*)sharedInstance{
    return sharedNetworkMediator;
}
//Genomför inloggningen
-(void)doLogin:(NSString*)username:(NSString*)password{
	NSString *str = @"http://www.sharps.se/forums/login.php?do=login";
	NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	Request *request = [Request requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *string = [[NSString alloc] initWithFormat:@"vb_login_username=%@&vb_login_password=%@&securitytoken=guest&do=login&cookieuser=1",username,password];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    request.delegate=self;
    [request setDidFinishSelector:@selector(loginDone:)];
    [[Connection alloc] initWithRequest:request];
}
//Undersöker om inloggningen lyckades genom att kontrollera kakan "vbseo_loggedin".
//Sedan anropar den delegatet med resultatet.
-(void)loginDone:(Request*)request{
    for (NSHTTPCookie* cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
        if ([cookie.name isEqualToString:@"vbseo_loggedin"]) {
            [loginDelegate loginDidSucceed:YES];
            if(!self.library){
                self.library=[[SpreadsheetLibrary alloc] init];
            }
            [self loadSpreadsheets];
            return;
        }
    }
    [loginDelegate loginDidSucceed:NO];
}
-(void)didFail:(Request*)request{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Network connection failed, check your connection!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
-(void)didFinish:(Request*)request{
}
-(void)didStart:(Request*)request{
}
//Hämtar alla spreadsheets
- (void)loadSpreadsheets{
    NSString *urlStr=@"http://www.sharps.se/forums/includes/ss/app_mysheets.php";
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    SpreadsheetRequestOP *cop=[[SpreadsheetRequestOP alloc] initWithURL:url AndGroup:0];
    [cop start];
    NSString *urlStr2=@"http://www.sharps.se/forums/includes/ss/app_favsheets.php";
    NSURL *url2 = [NSURL URLWithString:[urlStr2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	SpreadsheetRequestOP *cop2=[[SpreadsheetRequestOP alloc] initWithURL:url2 AndGroup:1];
    [cop2 start];
}

//Hämtar grafdatan för spreadsheetet "spreadsheet"
-(void)collectGraphDataForSheet:(NSMutableDictionary*)spreadsheet{
    NSString *urlStr= [NSString stringWithFormat:@"http://www.sharps.se/forums//includes/ss/fc_xml.php?id=%d&type=roi",[spreadsheet objectForKey:@"id"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	Request *request = [Request requestWithURL:url];
    [request addValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request addValue:@"sv-se" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //sätter taggen till spreadsheetets id för att kunna kontrollera vem datan tillhör
	[request setHTTPMethod:@"GET"];
    request.delegate=self;
    [request setDidFinishSelector:@selector(graphDataLoaded:)];
    request.tag=(NSInteger)[spreadsheet objectForKey:@"id"];
    [request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    Connection *connection= [[Connection alloc] initWithRequest:request];
}
//Skickar vidare datan för infogning i spreadsheet
-(void)graphDataLoaded:(Request*)request{
    [self.library generateGraphDataFrom:[request responseData] forSheet:request.tag];
}
- (void)requestStarted:(Request *)request{
}
- (void)requestFailed:(Request *)request{
}
- (void)requestRedirected:(Request *)request{
	NSLog(@"%@",[request responseString]);
}
//Lägger till spelet "game" i spreadsheetet "spreadsheet"
-(void)addOrEdit:(TableModes)mode Game:(NSMutableDictionary*)game toSheet:(NSMutableDictionary*)spreadsheet{
    NSMutableString *urlStr;
    if (mode==Add) {
       urlStr = [NSMutableString stringWithFormat: @"http://www.sharps.se/forums//includes/ss/ajax_edit_spreadsheet.php?id=%i&a=1", [spreadsheet objectForKey:@"id"]];
        [game setObject:@"1" forKey:@"isalive"];
    }else if(mode==Edit){
        urlStr = [NSMutableString stringWithFormat: @"http://www.sharps.se/forums//includes/ss/ajax_edit_spreadsheet.php?id=%i&a=de", [spreadsheet objectForKey:@"id"]];
        [game setObject:@"0" forKey:@"isalive"];
    }
    
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    GameUploadOperation *guo=[[GameUploadOperation alloc] initWithURL:url Method:@"POST" Spreadsheet:spreadsheet AndGame:game];
    [guo start];
}
-(void)getGamesForSpreadsheet:(NSMutableDictionary*)spreadsheet{
    int page=([[library.games objectForKey:[spreadsheet objectForKey:@"id"]] count]+1)/10;
    NSMutableString *urlStr= [NSMutableString stringWithFormat: @"http://www.sharps.se/forums/includes/ss/app_games.php?ssid=%@&page=%i", [spreadsheet objectForKey:@"id"],page];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    GetGamesOP *cop=[[GetGamesOP alloc] initWithURL:url ForSpreadsheet:spreadsheet];
    [cop start];
}
-(void)getGameRequestFailed:(Request*) request{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Hämtning av spelen misslyckades, kolla din anslutning" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
-(void)getGameRequestFinished:(Request*) request{

}
//Sätter resultatet "result" för matchen "game" i spreadsheetet "spreadsheet"
-(void)setResult:(NSString*)result toGame:(NSMutableDictionary*)game inSpreadsheet:(NSMutableDictionary*)spreadsheet{
    NSString *urlStr= [NSString stringWithFormat: @"http://www.sharps.se/forums//includes/ss/ajax_edit_spreadsheet.php?id=%i&grade=%@&to=%@", [spreadsheet objectForKey:@"id"],[game objectForKey:@"spelid"],result];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    Request *request = [Request requestWithURL:url];
	[request setHTTPMethod:@"POST"];
    Connection *connection= [[Connection alloc] initWithRequest:request];
}
-(void)updateSpreadsheets{
    [library.sheets removeAllObjects];
    [library.games removeAllObjects];
    [self loadSpreadsheets];
}
@end