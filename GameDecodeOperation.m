//
//  GameDecodeOperation.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameDecodeOperation.h"
#import "SpreadsheetLibrary.h"
@implementation GameDecodeOperation
@synthesize sheetParser;
@synthesize currentValue;
@synthesize currentSpreadsheet;
@synthesize currentGame;
@synthesize currentParlay;
@synthesize networkMediator;
- (id)initWithData:(id)data Sheet:(NSMutableDictionary*)sheet{
    if (self = [super init]){
        myData = data;
        currentSpreadsheet=sheet;
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
    if([elementName isEqualToString:@"game"]){
        if (![networkMediator.library.games objectForKey:[currentSpreadsheet objectForKey:@"id"]]) {
            [networkMediator.library.games setObject:[[NSMutableArray alloc] init] forKey:[currentSpreadsheet objectForKey:@"id"]];
        }
    }else if([elementName isEqualToString:@"subgame"]){
        currentParlay=[[NSMutableDictionary alloc] init];
    }else if([elementName isEqualToString:@"subgames"]){
        isParlay=YES;
        [currentGame setObject:[[NSMutableArray alloc] init] forKey:@"subgames"];
    }
    self.currentValue=[[NSMutableString alloc] initWithString: @"Not Specified"];
}
//Laddar in att spreadsheet data i currentSpreadsheet
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"parlay"]){
        currentGame=[[NSMutableDictionary alloc] init];
        [currentGame setObject:currentValue forKey:elementName];
    }else if([elementName isEqualToString:@"game"]){
        [[networkMediator.library.games objectForKey:[currentSpreadsheet objectForKey:@"id"]] addObject:currentGame];
        isParlay=NO;
    }
    else if([elementName isEqualToString:@"subgame"]){
        [((NSMutableArray*)[currentGame objectForKey:@"subgames"])addObject:currentParlay];
    }else{
        if(isParlay){
            [currentParlay setObject:currentValue forKey:elementName];
        }else{
            [currentGame setObject:currentValue forKey:elementName];
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
    if (networkMediator.tableView) {
        [networkMediator.tableView reloadData];
    }
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [networkMediator.downloading removeObjectForKey:[currentSpreadsheet objectForKey:@"id"]];
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}
@end
