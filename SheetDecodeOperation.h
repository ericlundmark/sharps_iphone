//
//  SheetDecodeOperation.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpreadsheetGroup.h"
@class NetworkMediator;
@class Spreadsheet;
@class SpreadsheetLibrary;
@interface SheetDecodeOperation : NSOperation <NSXMLParserDelegate>{
    id myData;
    BOOL        executing;
    BOOL        finished;
    NSXMLParser *sheetParser;
    SpreadsheetGroup spreadsheetGroup;
    NSMutableDictionary *currentSpreadsheet;
    NSMutableString *currentValue;
    NetworkMediator *networkMediator;
}
@property(nonatomic,strong)NSXMLParser *sheetParser;
@property(nonatomic)SpreadsheetGroup spreadsheetGroup;
@property(nonatomic,strong)NSMutableDictionary *currentSpreadsheet;
@property(nonatomic,strong) NSMutableString *currentValue;
@property(nonatomic,strong) NetworkMediator *networkMediator;
- (id)initWithData:(id)data Group:(SpreadsheetGroup)group;
- (void)completeOperation;
@end
