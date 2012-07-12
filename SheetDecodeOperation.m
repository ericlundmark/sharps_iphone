//
//  SheetDecodeOperation.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SheetDecodeOperation.h"
#import "NetworkMediator.h"
#import "SpreadsheetLibrary.h"
@implementation SheetDecodeOperation
@synthesize sheetParser;
@synthesize spreadsheetGroup;
@synthesize currentValue;
@synthesize currentSpreadsheet;
@synthesize networkMediator;

- (id)initWithData:(id)data Group:(SpreadsheetGroup)group {
    if (self = [super init]){
        myData = data;
        spreadsheetGroup=group;
        networkMediator=[NetworkMediator sharedInstance];
    }
    return self;
}
-(void)main {
    @try {
        sheetParser = [[NSXMLParser alloc] initWithData:myData];
        [sheetParser setDelegate:self];
        [sheetParser parse];
    }
    @catch(...) {
        // Do not rethrow exceptions.
    }
}
- (void)start {
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}
- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //För att undvika problem med tomma taggar
    self.currentValue=[[NSMutableString alloc] initWithString: @"Not Specified"];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"title"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"title"];
    } else if([elementName isEqualToString:@"roi"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"roi"];
    }else if([elementName isEqualToString:@"winp"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"winp"];
    }else if([elementName isEqualToString:@"games"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"games"];
    }else if([elementName isEqualToString:@"win"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"win"];
    }else if([elementName isEqualToString:@"loss"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"loss"];
    }else if([elementName isEqualToString:@"push"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"push"];
    }else if([elementName isEqualToString:@"lastgame"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"lastGame"];
    }else if([elementName isEqualToString:@"lastadded"]){
        [currentSpreadsheet setObject:currentValue.copy forKey:@"lastAdded"];
    }else if([elementName isEqualToString:@"id"]){
        [networkMediator.library.sheets setObject:[[NSMutableDictionary alloc ]init] forKey:currentValue];
        currentSpreadsheet=[networkMediator.library.sheets objectForKey:currentValue];
        [currentSpreadsheet setObject:currentValue forKey:@"id"];
        if (spreadsheetGroup==MY) {
            networkMediator.library.nuOfMy++;
            [currentSpreadsheet setObject:@"my" forKey:@"group"];
        } else {
            networkMediator.library.nuOfFav++;
            [currentSpreadsheet setObject:@"fav" forKey:@"group"];
        }
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.currentValue isEqualToString:@"Not Specified"]) {
        self.currentValue = [[NSMutableString alloc] initWithString:string];
    } else {
        [self.currentValue appendString:string];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [self completeOperation];
}
- (void)completeOperation {
    [networkMediator.library.my removeAllObjects];
    [networkMediator.library.fav removeAllObjects];
    for (NSMutableDictionary *dict in networkMediator.library.sheets.allValues) {
        if ([[dict objectForKey:@"group"] isEqualToString:@"my"]) {
            [networkMediator.library.my addObject:dict];
        }else{
            [networkMediator.library.fav addObject:dict];
        }
        //[networkMediator getGamesForSpreadsheet:dict];
    }
    [networkMediator.masterView.tableView reloadData];
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}
@end
