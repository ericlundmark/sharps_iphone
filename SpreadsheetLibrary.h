//
//  SpreadsheetLibrary.h
//  sharps
//
//  Created by Eric Lundmark on 2011-12-22.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SheetDecodeOperation.h"
#import "GameDecodeOperation.h"
#import "Request.h"
@interface SpreadsheetLibrary : NSObject{
    NSMutableDictionary *sheets;
    NSMutableDictionary *games;
    NSMutableArray *my;
    NSMutableArray *fav;
    int nuOfMy;
    int nuOfFav;
    BOOL currentGroupIsMy;
    NSString *currentValue;
    NSMutableDictionary *currentSpreadsheet;
    NSMutableDictionary *currentGame;

    NSMutableDictionary *graphData;
    NSMutableDictionary *signDictionary;
    NSOperationQueue *sharedOperationQueue;
    
}
@property (nonatomic,strong)NSMutableDictionary *sheets;
@property (nonatomic,strong)NSMutableDictionary *games;
@property (nonatomic, strong)NSMutableArray *my;
@property (nonatomic, strong)NSMutableArray *fav;
@property (nonatomic)int nuOfMy;
@property (nonatomic)int nuOfFav;

//Temporära varaibler för inladdning av data
@property (nonatomic) BOOL currentGroupIsMy;
@property (nonatomic,strong) NSString *currentValue;
@property (nonatomic,strong) NSMutableDictionary *currentSpreadsheet;
@property (nonatomic,strong) NSMutableDictionary *currentGame;
@property (nonatomic,strong) NSOperationQueue *sharedOperationQueue;
@property (nonatomic,strong) NSMutableDictionary *signDictionary;



-(void)generateGraphDataFrom:(NSData*)xmlData forSheet:(NSInteger)sheetID;
-(void)getSpreadsheetDataFrom:(NSData*)data InGroup:(NSInteger)group;
-(void)generateGamesFrom:(NSData*)xmlData forSheet:(NSMutableDictionary*)sheet;
@end
