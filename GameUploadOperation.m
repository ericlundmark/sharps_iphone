//
//  GameUploadOperation.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-05-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameUploadOperation.h"
#import "NetworkMediator.h"
#import "SpreadsheetLibrary.h"
@implementation GameUploadOperation
@synthesize networkMediator;
@synthesize url;
@synthesize response;
@synthesize httpMethod;
@synthesize active;
@synthesize finished;
@synthesize spreadsheet;
@synthesize gameToUpload;
- (id)initWithURL:(NSURL*)URL Method:(NSString*)method Spreadsheet:(NSMutableDictionary*)sheet AndGame:(NSMutableDictionary*)game{
    self = [super init];
    if (self){
        networkMediator=[NetworkMediator sharedInstance];
        url=URL;
        httpMethod=method;
        spreadsheet=sheet;
        gameToUpload=game;
        response=[[NSMutableData alloc] init];
    }
    return self;
}
-(void)start{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
    [request setHTTPMethod:httpMethod];
    [request addValue:@"sv-se" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request addValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    /*
    if ([[gameToUpload objectForKey:@"sign"] isEqualToString:@"Hemmalag"]) {
        [[gameToUpload objectForKey:@"sign"] setString:@"1"];
    }else if ([[gameToUpload objectForKey:@"sign"] isEqualToString:@"Bortalag"]) {
        [[gameToUpload setObject:@"2" forKey:@""] setString:@"2"];
    }else if ([gameToUpload.sign isEqualToString:@"Över"]) {
        [[gameToUpload objectForKey:@"sign"] setString:@"over"];
    }else if ([gameToUpload.sign isEqualToString:@"Under"]) {
        [[gameToUpload objectForKey:@"sign"] setString:@"under"];
    }
    NSString *myRequestString = [[NSString alloc] initWithFormat:@"date=%@&time=%@&league=%@&sport=%@&country=%@&team1=%@&team2=%@&sign=%@&sign2=%@&amount=%@&odds=%@&info=%@&isalive=%@&locked=%@&result=%@&rekare=%@&bolag=%@&live=%@&period=%@",gameToUpload.date,gameToUpload.time,gameToUpload.league,gameToUpload.sport,gameToUpload.country,gameToUpload.home,gameToUpload.away,gameToUpload.sign,gameToUpload.sign2,gameToUpload.stake,gameToUpload.odds,gameToUpload.info,gameToUpload.isAlive,gameToUpload.lock,gameToUpload.result,gameToUpload.rekare,gameToUpload.company,gameToUpload.live,gameToUpload.period];
    NSData *myRequestData = [myRequestString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody: myRequestData];
     */
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    active=YES;
    finished=NO;
    while(!finished){
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantPast]];
    }
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    active=NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Network connection failed, check your connection!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [response appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"didfinish uploading game %@",[[NSString alloc] initWithData:connection.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    [self completeOperation];
}

- (void)completeOperation {
    //[spreadsheet.games insertObject:gameToUpload atIndex:0];
    [networkMediator loadSpreadsheets];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateGames" object:nil];
    finished=YES;
    active=NO;
}
@end
