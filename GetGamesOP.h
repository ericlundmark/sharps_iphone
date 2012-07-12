//
//  GetGamesOP.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionOperation.h"
@class NetworkMediator;
@class SpreadsheetLibrary;
@interface GetGamesOP : ConnectionOperation{
    NSMutableDictionary *sheet;
}
@property(nonatomic,strong) NSMutableDictionary *sheet;
- (id)initWithURL:(NSURL *)URL ForSpreadsheet:(NSMutableDictionary*)spreadsheet;
@end
