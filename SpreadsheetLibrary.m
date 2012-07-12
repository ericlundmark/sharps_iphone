//
//  SpreadsheetLibrary.m
//  sharps
//
//  Created by Eric Lundmark on 2011-12-22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SpreadsheetLibrary.h"

@implementation SpreadsheetLibrary
@synthesize currentValue;
@synthesize currentSpreadsheet;
@synthesize currentGame;
@synthesize currentGroupIsMy;
@synthesize sharedOperationQueue;
@synthesize signDictionary;
@synthesize sheets;
@synthesize games;
@synthesize nuOfMy;
@synthesize nuOfFav;
@synthesize my;
@synthesize fav;
- (id)init {
    self = [super init];
    if (self) {
        sharedOperationQueue = [[NSOperationQueue alloc] init];
        signDictionary =[[NSMutableDictionary alloc]init];
        sheets=[[NSMutableDictionary alloc] init];
        games=[[NSMutableDictionary alloc] init];
        my=[[NSMutableArray alloc] init];
        fav=[[NSMutableArray alloc] init];
        [signDictionary setValue:@"1" forKey:@"Hemmalag"];
        [signDictionary setValue:@"2" forKey:@"Bortalag"];
        [signDictionary setValue:@"over" forKey:@"Över"];
        [signDictionary setValue:@"under" forKey:@"Under"];
    }
    return self;
}
//Plockar ut spreadsheets från xml data
-(void)getSpreadsheetDataFrom:(NSData*)data InGroup:(NSInteger)group{
    if(group==0){
        SheetDecodeOperation *theOp=[[SheetDecodeOperation alloc] initWithData:data Group:MY];
        [sharedOperationQueue addOperation:theOp];
    }else if(group==1){
        SheetDecodeOperation *theOp=[[SheetDecodeOperation alloc] initWithData:data Group:FAV];
        [sharedOperationQueue addOperation:theOp];
    }
}
//Plockar ut grafdata från xmlData till spreadsheetet med sheetID
-(void)generateGraphDataFrom:(NSData*)xmlData forSheet:(NSInteger)sheetID{
    /*
    currentSpreadsheet=[self SpreadsheetByID:sheetID];
    NSInvocationOperation* theOp = [[NSInvocationOperation alloc] initWithTarget:graphParser
                                                                        selector:@selector(parse:) object:nil];
    [sharedOperationQueue addOperation:theOp];
     */
}
-(void)generateGamesFrom:(NSData*)xmlData forSheet:(NSMutableDictionary*)sheet{
    GameDecodeOperation *theOp=[[GameDecodeOperation alloc]initWithData:xmlData Sheet:sheet];
    [sharedOperationQueue addOperation:theOp];
}
@end
