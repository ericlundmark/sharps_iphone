//
//  NetworkMediatorDelegate.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
@protocol  NetworkMediatorDelegate <NSObject>
-(void)didFail:(Request*)request;
-(void)didFinish:(Request*)request;
-(void)didStart:(Request*)request;
@end
