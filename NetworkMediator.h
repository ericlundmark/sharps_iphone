//
//  NetworkMediator.h
//  sharps
//
//  Created by Eric Lundmark on 2011-12-24.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDelegate.h"
#import "NetworkMediatorDelegate.h"
typedef enum {Edit,Add,View} TableModes;
@class SpreadsheetLibrary;
@class Connection;
@class Request;
@class SpreadsheetRequestOP;
@class GetGamesOP;
@class GameUploadOperation;
@interface NetworkMediator : NSObject<NetworkMediatorDelegate,UIAlertViewDelegate>{
    SpreadsheetLibrary *library;
    NetworkMediator *sharedNetworkMediator;
    id <LoginDelegate> loginDelegate;
    BOOL sheetsFinishedLoading;
    BOOL sheetsFailedLoading;
    NSMutableDictionary *downloading;
    UITableViewController *masterView;
    UITableView *tableView;
}
//Innehåller alla Spreadsheet
@property (nonatomic, strong) SpreadsheetLibrary *library;
@property (nonatomic, strong) id  <LoginDelegate> loginDelegate;
@property (nonatomic, strong) UITableViewController *masterView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) BOOL sheetsFinishedLoading;
@property (nonatomic) BOOL sheetsFailedLoading;
@property (nonatomic,strong) NSMutableDictionary *downloading;


-(void)doLogin:(NSString*)username:(NSString*) password;
-(void)loginDone:(Request*) request;
-(void)graphDataLoaded:(Request*)request;
-(void)loadSpreadsheets;
-(void)collectGraphDataForSheet:(NSMutableDictionary*)spreadsheet;
-(void)addOrEdit:(TableModes)mode Game:(NSMutableDictionary*)game toSheet:(NSMutableDictionary*)spreadsheet;
-(void)setResult:(NSString*)result toGame:(NSMutableDictionary*)game inSpreadsheet:(NSMutableDictionary*)spreadsheet;
-(void)getGameRequestFailed:(Request*) request;
-(void)getGameRequestFinished:(Request*) request;
-(void)getGamesForSpreadsheet:(NSMutableDictionary*)spreadsheet;
-(void)updateSpreadsheets;
+(NetworkMediator*)sharedInstance;

@end