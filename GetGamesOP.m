//
//  GetGamesOP.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetGamesOP.h"
#import "NetworkMediator.h"
#import "SpreadsheetLibrary.h"
@implementation GetGamesOP
@synthesize sheet;
- (id)initWithURL:(NSURL *)URL ForSpreadsheet:(NSMutableDictionary*)spreadsheet {
    self = [super initWithURL:URL AndMethod:@"POST"];
    if (self) {
        sheet=spreadsheet;
    }
    return self;
}
- (void)completeOperation {
    [super completeOperation];
    [networkMediator.library generateGamesFrom:response forSheet:sheet];
}
@end
