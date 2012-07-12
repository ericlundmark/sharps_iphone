//
//  ConnectionOperation.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NetworkMediator;
@class SpreadsheetLibrary;
@interface ConnectionOperation:NSObject <NSURLConnectionDelegate>{
    NSURL *url;
    NetworkMediator *networkMediator;
    NSMutableData *response;
    NSString *httpMethod;
    BOOL active;
    BOOL finished;
}
@property(nonatomic,strong) NetworkMediator *networkMediator;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)NSMutableData *response;
@property(nonatomic,strong)NSString *httpMethod;
@property(nonatomic)BOOL active;
@property(nonatomic)BOOL finished;
- (id)initWithURL:(NSURL*)URL AndMethod:(NSString*)method;
- (void)completeOperation;
- (void)start;
@end
