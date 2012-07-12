//
//  Request.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Request.h"

@implementation Request
@synthesize tag;
@synthesize game;
@synthesize responseData;
@synthesize responseString;
@synthesize body;
@synthesize didFinishSelector;
@synthesize didFailSelector;
@synthesize didStartSelector;
@synthesize delegate;
-(id)init{
    self=[super init];
    delegate=self;
    [self setDidFinishSelector:@selector(didFinish:)];
    [self setDidFailSelector:@selector(didFail:)];
    [self setDidStartSelector:@selector(didStart:)];
    return self;
}
-(id)initWithURL:(NSURL *)URL{
    self=[super initWithURL:URL];
    delegate=self;
    body=[[NSMutableString alloc] init];
    [self setDidFinishSelector:@selector(didFinish:)];
    [self setDidFailSelector:@selector(didFail:)];
    [self setDidStartSelector:@selector(didStart:)];
    return self;
}
-(void)setPostValue:(NSString*)value forKey:(NSString*)key{
    [self.body appendFormat:@"%@=%@&",key,value];
    self.HTTPBody= [self.body dataUsingEncoding:NSUTF8StringEncoding];
}
-(void)didFail:(Request*)request{
}
-(void)didFinish:(Request*)request{
}
-(void)didStart:(Request*)request{
}
@end
