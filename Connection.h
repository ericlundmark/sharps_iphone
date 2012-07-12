//
//  Connection.h
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
@interface Connection : NSURLConnection<NSURLConnectionDelegate>{
    Request *_request;
}
@property (nonatomic,strong) Request *_request;
-(id)initWithRequest:(Request *)request;
@end
