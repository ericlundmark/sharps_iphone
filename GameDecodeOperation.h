//
//  GameDecodeOperation.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkMediator.h"
@class SpreadsheetLibrary;
@interface GameDecodeOperation : NSOperation<NSXMLParserDelegate>{
    id myData;
    BOOL        executing;
    BOOL        finished;
    BOOL        isParlay;
    NSXMLParser *sheetParser;
    NSMutableDictionary *currentSpreadsheet;
    NSMutableString *currentValue;
    NSMutableDictionary *currentGame;
    NSMutableDictionary *currentParlay;
    NetworkMediator *networkMediator;
}
@property(nonatomic,strong)NSXMLParser *sheetParser;
@property(nonatomic,strong)NSMutableDictionary *currentSpreadsheet;
@property (nonatomic,strong) NSMutableString *currentValue;
@property (nonatomic,strong) NSMutableDictionary *currentGame;
@property (nonatomic,strong) NSMutableDictionary *currentParlay;
@property (nonatomic,strong) NetworkMediator *networkMediator;
- (id)initWithData:(id)data Sheet:(NSMutableDictionary*)sheet;
- (void)completeOperation;

@end
