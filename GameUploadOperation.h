//
//  GameUploadOperation.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-05-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NetworkMediator;
@class SpreadsheetLibrary;
@interface GameUploadOperation :NSObject <NSURLConnectionDelegate>{
    NSURL *url;
    NetworkMediator *networkMediator;
    NSMutableData *response;
    NSString *httpMethod;
    BOOL active;
    BOOL finished;
    NSMutableDictionary *spreadsheet;
    NSMutableDictionary *gameToUpload;
}
@property(nonatomic,strong) NetworkMediator *networkMediator;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)NSMutableData *response;
@property(nonatomic,strong)NSString *httpMethod;
@property(nonatomic,strong)NSMutableDictionary *spreadsheet;
@property(nonatomic,strong)NSMutableDictionary *gameToUpload;
@property(nonatomic)BOOL active;
@property(nonatomic)BOOL finished;
- (id)initWithURL:(NSURL*)URL Method:(NSString*)method Spreadsheet:(NSMutableDictionary*)sheet AndGame:(NSMutableDictionary*)game;
- (void)completeOperation;
- (void)start;
@end
