//
//  Request.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Request : NSMutableURLRequest{
    NSUInteger tag;
    NSMutableDictionary *game;
    NSMutableData *responseData;
    NSMutableString *responseString;
    NSMutableString *body;
    SEL didFinishSelector;
    SEL didFailSelector;
    SEL didStartSelector;
    id delegate;
}
@property (assign)SEL didFinishSelector;
@property (assign)SEL didFailSelector;
@property (assign)SEL didStartSelector;
@property (nonatomic) NSUInteger tag;
@property (nonatomic,strong) NSMutableDictionary *game;
@property (nonatomic,strong) NSMutableData *responseData;
@property (nonatomic,strong) NSMutableString *responseString;
@property (nonatomic,strong)NSMutableString *body;
@property (nonatomic,strong)id delegate;
-(void)setPostValue:(NSString*)value forKey:(NSString*)key;
-(void)didFail:(Request*)request;
-(void)didFinish:(Request*)request;
-(void)didStart:(Request*)request;
@end
