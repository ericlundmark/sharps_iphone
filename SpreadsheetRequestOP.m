//
//  SpreadsheetRequestOP.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpreadsheetRequestOP.h"
#import "SpreadsheetLibrary.h"
@implementation SpreadsheetRequestOP
@synthesize group;
- (id)initWithURL:(NSURL*)URL AndGroup:(NSInteger)sheetGroup{
    self=[super initWithURL:URL AndMethod:@"GET"];
    group=sheetGroup;
    return self;
}
- (void)completeOperation {
    [networkMediator.library getSpreadsheetDataFrom:response InGroup:group];
    [super completeOperation];
}
@end
