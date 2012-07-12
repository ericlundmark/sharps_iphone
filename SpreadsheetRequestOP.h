//
//  SpreadsheetRequestOP.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-20.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionOperation.h"
@class SpreadsheetLibrary;
@interface SpreadsheetRequestOP : ConnectionOperation{
    NSInteger group;
}
@property(nonatomic) NSInteger group;
- (id)initWithURL:(NSURL*)URL AndGroup:(NSInteger)sheetGroup;
@end
