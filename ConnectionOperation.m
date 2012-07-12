//
//  ConnectionOperation.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionOperation.h"
#import "NetworkMediator.h"
#import "SpreadsheetLibrary.h"
@implementation ConnectionOperation
@synthesize networkMediator;
@synthesize url;
@synthesize response;
@synthesize httpMethod;
@synthesize active;
@synthesize finished;
- (id)initWithURL:(NSURL*)URL AndMethod:(NSString*)method{
    self = [super init];
    if (self){
        networkMediator=[NetworkMediator sharedInstance];
        url=URL;
        httpMethod=method;
        response=[[NSMutableData alloc] init];
    }
    return self;
}
-(void)start{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
    [request setHTTPMethod:httpMethod];
    [request addValue:@"sv-se" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request addValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
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
    [self completeOperation];
}

- (void)completeOperation {
    finished=YES;
    active=NO;
}
@end
